import yaml
import click
import glob
from client import PolicyServiceClient
from exclude import excluded_templates

DEFAULT_PROVIDER = "kubernetes"

class FileLoader:
    def __init__(self, path: str):
        self.path = path

    def load_templates(self):
        templates = []
        files = glob.glob(f"{self.path}/**/policy.yaml", recursive=True)
        for file_path in files:
            if file_path not in excluded_templates:
                with open(file_path) as fd:
                    template = yaml.safe_load(fd)
                    templates.append(template["spec"])
        return templates

class TemplateSyncer:
    def __init__(self, policies_service: str, magalix_account: str, templates_dir: str):
        self._client = PolicyServiceClient(url=policies_service, magalix_account=magalix_account)
        self._file_loader = FileLoader(path=templates_dir) 

    def _check_required_fields(self, template: dict):
        for field in ["id", "name", "description", "how_to_solve", "code", "severity", "category"]:
            if not template.get(field):
                raise Exception(f"[ERROR] Could not sync template; Missing {field} field.")
        if (
            not template.get("targets")
            or not template["targets"].get("kind")
            or template["targets"]["kind"] == []
        ):
            raise Exception(f"[ERROR] Could not sync {template['name']} template. "\
                            "Template must have targets kind set to value; "\
                            "for example 'kind: [Deployment]'")

    def _fetch_remote_templates(self):
        response = self._client.query_templates(filters={"magalix": True})
        remote_templates = {pol["id"]: pol for pol in response.json()["data"]}
        return remote_templates

    def _create_new_template(self, template: dict):
        click.secho(f"Creating template {template['name']}", fg="green")
        template_id = self._client.create_template(template=template)

    def _update_template(self, template: dict, remote_template: dict):
        for field in template.keys():
            if str(template.get(field)).strip() != str(remote_template.get(field)).strip():
                click.secho(f"Updating template {template['id']}", fg="yellow")
                self._client.update_template(template=template)
                break

    def _sync_deleted(self, templates: list, remote_templates: list):
        templates_map = {tmpl["id"]: tmpl for tmpl in templates}
        for template_id, _ in remote_templates.items():
            local_template = templates_map.get(template_id)
            if not local_template:
                click.secho(f"Deleting template {template_id}", fg="red")
                self._client.delete_template(template_id)

    def sync(self, new_only: bool = False, sync_deleted: bool = False):
        templates = self._file_loader.load_templates()
        remote_templates = self._fetch_remote_templates()

        for template in templates:
            self._check_required_fields(template=template)
            targets_schema = {
                "kind": [],
                "cluster": [],
                "namespace": [],
                "label": {},
            }
            targets_schema.update(template["targets"])
            template["targets"] = targets_schema

            if not template.get("provider"):
                template["provider"] = DEFAULT_PROVIDER

            remote_template = remote_templates.get(template["id"])
            if not remote_template:
                self._create_new_template(template=template)
                continue

            if not new_only:    # sync updates of old templates
                self._update_template(template=template, remote_template=remote_template)

        if sync_deleted:
            self._sync_deleted(templates=templates, remote_templates=remote_templates)