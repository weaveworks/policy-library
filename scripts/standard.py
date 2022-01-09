import yaml
import click
import glob
from utils import is_equal
from client import PolicyServiceClient

class FileLoader:
    def __init__(self, path: str):
        self.path = path

    def load_standards(self):
        standards = []
        files = glob.glob(f"{self.path}/**/standard.yaml", recursive=True)
        for file_path in files:
            with open(file_path) as fd:
                standard = yaml.safe_load(fd)
                standards.append(standard)
        return standards

class StandardSyncer:
    def __init__(self, policies_service: str, magalix_account: str, standards_dir: str):
        self._client = PolicyServiceClient(url=policies_service, magalix_account=magalix_account)
        self._file_loader = FileLoader(path=standards_dir)

    def _fetch_remote_standards(self):
        response = self._client.query_standards(filters={"magalix": True})
        remote_standards = {std["id"]: std for std in response.json()["data"]}
        for standard in remote_standards.values():
            response = self._client.query_controls(
                filters={"standard_ids": [standard["id"]]}
            )
            standard["controls"] = {ctrl["id"]: ctrl for ctrl in response.json()["data"]}
        return remote_standards

    def _create_new_standard(self, standard: dict):
        click.secho(f"Creating standard {standard['name']}", fg="green")
        self._client.create_standard(
            id=standard["id"],
            name=standard["name"],
            description=standard["description"]
        )
        for control in standard.get("controls", []):
            self._create_new_control(standard["id"], control)

    def _create_new_control(self, standard_id: str, control: dict):
        click.secho(f"Creating control {control['name']} in standard {standard_id}", fg="green")
        self._client.create_control(
            id=control["id"],
            name=control["name"],
            description=control["description"],
            order=control["order"],
            standard_id=standard_id,
        )

    def _update_standard(self, standard: dict, remote_standard: dict):
        for field in ["id", "name", "description"]:
            if not is_equal(standard.get(field), remote_standard.get(field)):
                click.secho(f"Updating standard {standard['id']}", fg="yellow")
                self._client.update_standard(
                    id=standard["id"],
                    name=standard["name"],
                    description=standard["description"],
                )
                break

    def _update_control(self, control: dict, remote_control: dict):
        for field in ["id", "name", "description", "order"]:
            if str(control[field]).strip() != str(remote_control[field]).strip():
                click.secho(f"Updating control {control['id']}", fg="yellow")
                self._client.update_control(
                    id=control['id'],
                    name=control["name"],
                    description=control["description"],
                    order=control["order"],
                )
                break

    def _sync_deleted(self, standards: list, remote_standards: list):
        standards_map = {std["id"]: std for std in standards}
        for standard_id, standard in remote_standards.items():
            local_standard = standards_map.get(standard_id)
            if not local_standard:
                for control_id in standard.get("controls").keys():
                    click.secho(f"Deleting control {control_id}", fg="red")
                    self._client.delete_control(control_id)

                click.secho(f"Deleting standard {standard_id}", fg="red")
                self._client.delete_standard(standard_id)
                continue

            controls_map = {ctrl["id"]: ctrl for ctrl in local_standard.get("controls", [])}
            for control_id, control in standard.get("controls").items():
                if not controls_map.get(control_id):
                    click.secho(f"Deleting control {control['id']}", fg="red")
                    self._client.delete_control(control_id)

    def sync(self, new_only: bool = False, sync_deleted: bool = False):
        standards = self._file_loader.load_standards()
        remote_standards = self._fetch_remote_standards()

        for standard in standards:
            remote_standard = remote_standards.get(standard["id"])
            if not remote_standard:
                self._create_new_standard(standard=standard)
                continue

            if not new_only:    # sync updates of old standards
                self._update_standard(standard=standard, remote_standard=remote_standard)

                for control in standard.get("controls", []):
                    remote_control = remote_standard["controls"].get(control["id"])
                    if not remote_control:
                        self._create_new_control(standard_id=standard["id"], control=control)
                        continue
                
                    self._update_control(control=control, remote_control=remote_control)

        if sync_deleted:
            self._sync_deleted(standards=standards, remote_standards=remote_standards)