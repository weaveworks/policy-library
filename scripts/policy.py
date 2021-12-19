import yaml
import click
import glob
import os
from client import PolicyServiceClient
from exclude import excluded_policies

DEFAULT_PROVIDER = "kubernetes"

class FileLoader:
    def __init__(self, path: str):
        self.path = path

    def load_policies(self):
        policies = []
        files = glob.glob(f"{self.path}/**/policy.yaml", recursive=True)
        for yaml_file in files:
            if os.path.basename(os.path.dirname(yaml_file)) not in excluded_policies:
                with open(yaml_file) as fd:
                    policy = yaml.safe_load(fd)
                    rego_file_path = os.path.join(
                        os.path.dirname(os.path.abspath(yaml_file)), "policy.rego")
                    with open(rego_file_path) as rego:
                        policy["spec"]["code"] = rego.read()
                    policies.append(policy["spec"])
        return policies

class PolicySyncer:
    def __init__(self, policies_service: str, magalix_account: str, policies_dir: str):
        self._client = PolicyServiceClient(url=policies_service, magalix_account=magalix_account)
        self._file_loader = FileLoader(path=policies_dir) 

    def _fetch_remote_policies(self):
        response = self._client.query_policies(filters={"magalix": True})
        remote_policies = {pol["id"]: pol for pol in response.json()["data"]}
        return remote_policies

    def _create_new_policy(self, policy: dict):
        click.secho(f"Creating policy {policy['name']}", fg="green")
        policy_id = self._client.create_policy(policy=policy)

    def _update_policy(self, policy: dict, remote_policy: dict):
        for field in policy.keys():
            if str(policy.get(field)).strip() != str(remote_policy.get(field)).strip():
                click.secho(f"Updating policy {policy['id']}", fg="yellow")
                self._client.update_policy(policy=policy)
                break

    def _sync_deleted(self, policies: list, remote_policies: list):
        policies_map = {pol["id"]: pol for pol in policies}
        for policy_id, _ in remote_policies.items():
            local_policy = policies_map.get(policy_id)
            if not local_policy:
                click.secho(f"Deleting policy {policy_id}", fg="red")
                self._client.delete_policy(policy_id)

    def sync(self, new_only: bool = False, sync_deleted: bool = False):
        policies = self._file_loader.load_policies()
        remote_policies = self._fetch_remote_policies()

        for policy in policies:
            targets_schema = {
                "kind": [],
                "cluster": [],
                "namespace": [],
                "label": {},
            }
            targets_schema.update(policy["targets"])
            policy["targets"] = targets_schema

            if not policy.get("provider"):
                policy["provider"] = DEFAULT_PROVIDER

            remote_policy = remote_policies.get(policy["id"])
            if not remote_policy:
                self._create_new_policy(policy=policy)
                continue

            if not new_only:    # sync updates of old policies
                self._update_policy(policy=policy, remote_policy=remote_policy)

        if sync_deleted:
            self._sync_deleted(policies=policies, remote_policies=remote_policies)