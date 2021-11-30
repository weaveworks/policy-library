import yaml
import requests
import click
import os
import glob
import uuid


MAGALIX_ACCOUNT = "816805bb-8311-4312-afac-ef3ba41d1287"
POLICIES_SVC_URL = "http://policies-service.cluster-advisor.svc/api/v1"

def _handle_api_error(response):
    if response.status_code >= 400 and response.status_code < 500:
        errors = response.json().get("errors", [])
        click.secho("[Errors]: %s" % ",".join(errors), fg="red")
        click.secho("[Errors]: request %s %s" % (response.request.method, response.request.url), fg="red")
    response.raise_for_status()

class PolicyServiceClient:
    def __init__(self, url: str, magalix_account: str):
        self.url = url.rstrip("/")
        self.magalix_account = magalix_account
        self.session = requests.Session()
        self.session.headers["X-ACCOUNT"] = magalix_account

    def _call_api(
        self,
        method: str,
        uri: str,
        params: dict = None,
        headers: dict = None,
        body: dict = None,
        die: bool = True
    ):
        url = os.path.join(self.url, uri)
        response = self.session.request(
            method, url, params=params, headers=headers, json=body
        )
        if die:
           _handle_api_error(response)
        else:
            if not response.ok:
                click.secho("[WARN] action is skipped, {}".format(response.json()), fg="yellow")

        return response

    def create_standard(self, rid: str, name: str, description: str):
        body = {"rid": rid, "name": name, "description": description}
        response = self._call_api("post", "standards", body=body, die=False)
        if not response.ok:
            if response.status_code == 409:
                response = self.query_standards(filters={"names": [name]})
                data = response.json()
                if data["count"] > 0:
                    return data["data"][0]["id"]
            else:
                _handle_api_error(response)
        return response.json()["id"]

    def update_standard(self, uid: str, rid: str, name: str, description: str):
        body = {"rid": rid, "name": name, "description": description}
        return self._call_api("put", f"standards/{uid}", body=body)

    def delete_standard(self, uid: str):
        return self._call_api("delete", f"standards/{uid}", die=False)

    def get_standard(self, uid: str):
        return self._call_api("get", f"standards/{uid}")

    def query_standards(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"standards/query", body=body)

    def create_control(self, name: str, description: str, order: str, standard_id: str):
        body = {
            "name": name,
            "description": description,
            "order": str(order),
            "standard_id": standard_id,
        }
        response = self._call_api("post", "controls", body=body, die=False)
        if not response.ok:
            if response.status_code == 409:
                response = self.query_controls(filters={"names": [name]})
                data = response.json()
                if data["count"] > 0:
                    return data["data"][0]["id"]
            else:
                _handle_api_error(response)
        return response.json()["id"]

    def update_control(self, uid: str, name: str, description: str, order: str):
        body = {"name": name, "description": description, "order": str(order)}
        return self._call_api("put", f"controls/{uid}", body=body)

    def delete_control(self, uid: str):
        return self._call_api("delete", f"controls/{uid}", die=False)

    def get_control(self, uid: str):
        return self._call_api("get", f"controls/{uid}")

    def query_controls(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"controls/query", body=body)


class Loader:
    def __init__(self, path: str = None):
        if path is None:
            self.path = os.path.join(os.path.dirname(__file__), "standards")
        else:
            self.path = path

    def load(self):
        standards = []
        files = glob.glob(f"{self.path}/**/*.yaml", recursive=True)
        for file_path in files:
            with open(file_path) as fd:
                standard = yaml.safe_load(fd)
                standard["__path__"] = file_path
                standards.append(standard)
        return standards

class Syncer:
    def __init__(self, loader: Loader, client: PolicyServiceClient, environment: str):
        self.loader = loader
        self.client = client
        self.environment = environment
    
    @property
    def environment_id_key(self):
        return f"{self.environment}_id"
    
    def generate_uuid(self):
        return str(uuid.uuid4()) 

    def _save_standard(self, standard: dict):
        updated = standard.copy()
        path = updated.pop("__path__")
        with open(path, "w") as f:
            yaml.safe_dump(updated, f)

    def _create_new_standard(self, standard: dict):
        standard_id = self.client.create_standard(
            rid=standard["rid"],
            name=standard["name"],
            description=standard["description"]
        )

        standard[self.environment_id_key] = standard_id
        if not standard.get("id"):
            standard["id"] = self.generate_uuid()

        for control in standard.get("controls", []):
            click.secho("Creating control %s" % control["name"], fg="green")
            control_id = self.client.create_control(
                name=control["name"],
                description=control["description"],
                order=control["order"],
                standard_id=standard_id,
            )
            
            control[self.environment_id_key] = control_id
            if not control.get("id"):
                control["id"] = self.generate_uuid()

    def _collect_remote_standards(self):
        response = self.client.query_standards(filters={"magalix": True})
        remote_standards = {x["id"]: x for x in response.json()["data"]}
        for standard in remote_standards.values():
            response = self.client.query_controls(
                filters={"standard_ids": [standard["id"]]}
            )
            standard["controls"] = {x["id"]: x for x in response.json()["data"]}

        return remote_standards

    def sync(self, environment: str, new_only: bool = False, delete_not_exits: bool = False):
        standards = self.loader.load()
        remote_standards = self._collect_remote_standards()

        for standard in standards:
            standard_id = standard.get(self.environment_id_key)
            if not standard_id:
                click.secho("Creating standard %s" % standard["name"], fg="green")
                self._create_new_standard(standard)
                self._save_standard(standard)
                continue

            remote_standard = remote_standards.get(standard_id)
            if not remote_standard:
                click.secho("Creating standard %s" % standard["name"], fg="green")
                self._create_new_standard(standard)
                self._save_standard(standard)
                continue

            if new_only:
                continue

            out_of_date = False
            for field in ["rid", "name", "description"]:
                if str(standard.get(field)).strip() != str(remote_standard.get(field)).strip():
                    out_of_date = True
                    break

            if out_of_date:
                click.secho("Updating standard %s" % standard[self.environment_id_key], fg="yellow")
                self.client.update_standard(
                    uid=standard_id,
                    rid=standard["rid"],
                    name=standard["name"],
                    description=standard["description"],
                )

            for control in standard.get("controls", []):
                control_id = control.get(self.environment_id_key)
                if not control_id:
                    click.secho("Creating control %s" % control["name"], fg="green")
                    control_id = self.client.create_control(
                        name=control["name"],
                        description=control["description"],
                        order=control["order"],
                        standard_id=standard_id,
                    )

                    control[self.environment_id_key] = control_id
                    if not control.get("id"):
                        control["id"] = self.generate_uuid()

                    self._save_standard(standard)
                    continue

                remote_control = remote_standard["controls"].get(control_id)
                if not remote_control:
                    click.secho("Creating control %s" % control["name"], fg="green")
                    control_id = self.client.create_control(
                        name=control["name"],
                        description=control["description"],
                        order=control["order"],
                        standard_id=standard_id,
                    )
                    
                    control[self.environment_id_key] = control_id
                    if not control.get("id"):
                        control["id"] = self.generate_uuid()
        
        
                    self._save_standard(standard)
                    continue

                out_of_date = False
                for field in ["name", "description", "order"]:
                    if str(control[field]).strip() != str(remote_control[field]).strip():
                        out_of_date = True
                        break

                if out_of_date:
                    click.secho("Updating control %s" % control["id"], fg="yellow")
                    self.client.update_control(
                        uid=control_id,
                        name=control["name"],
                        description=control["description"],
                        order=control["order"],
                    )

        if delete_not_exits:
            standard_map = {x[self.environment_id_key]: x for x in standards}
            for standard_id, standard in remote_standards.items():
                local_standard = standard_map.get(standard_id)
                if not local_standard:
                    for control_id in standard.get("controls").keys():
                        click.secho("Deleting control %s" % control_id, fg="red")
                        self.client.delete_control(control_id)

                    click.secho("Deleting standard %s" % standard_id, fg="red")
                    self.client.delete_standard(standard_id)
                    continue

                controls_map = {x[self.environment_id_key]: x for x in local_standard.get("controls", [])}
                for control_id, control in standard.get("controls").items():
                    if not controls_map.get(control_id):
                        click.secho("Deleting control %s" % control["id"], fg="red")
                        self.client.delete_control(control_id)


@click.command()
@click.option("--standards-dir", "-d", required=True, help="standards directory")
@click.option("--magalix-account", "-a", required=True, default=MAGALIX_ACCOUNT, help="magalix account id")
@click.option("--policies-service", "-s", required=True, default=POLICIES_SVC_URL, help="policies service url")
@click.option("--environment", "-e", required=True,  type=click.Choice(['dev', 'prod']), help="environment")
@click.option("--new-only", is_flag=True, default=False, help="sync only new standards")
@click.option("--delete-not-exits", is_flag=True, default=False, help="delete old standards and controls")
def cli(standards_dir, magalix_account, policies_service, environment, new_only, delete_not_exits):
    loader = Loader(path=standards_dir)
    client = PolicyServiceClient(
        url=policies_service, magalix_account=magalix_account
    )
    syncer = Syncer(client=client, loader=loader, environment=environment)
    syncer.sync(environment=environment, new_only=new_only, delete_not_exits=delete_not_exits)


if __name__ == "__main__":
    cli()
