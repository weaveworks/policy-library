
import click
import yaml
import os
from utils import is_equal
from client import PolicyServiceClient


class FileLoader:
    def __init__(self, path: str):
        self.path = path

    def load_categories(self):
        categories = []
        with open(os.path.join(self.path, "categories.yaml")) as fd:
            categories = yaml.safe_load(fd)
        return categories["categories"]

class CategorySyncer:
    def __init__(self, policies_service: str, magalix_account: str, categories_dir: str):
        self._client = PolicyServiceClient(url=policies_service, magalix_account=magalix_account)
        self._file_loader = FileLoader(path=categories_dir) 

    def _fetch_remote_categories(self):
        response = self._client.query_categories(filters={"magalix": True})
        remote_categories = {cat["id"]: cat for cat in response.json()["data"]}
        return remote_categories

    def _create_new_category(self, category: dict):
        click.secho(f"Creating category {category['name']}", fg="green")
        self._client.create_category(
            id=category["id"],
            name=category["name"],
        )
    
    def _update_category(self, category: dict, remote_category: dict):
        for field in ["id", "name"]:
            if not is_equal(category.get(field), remote_category.get(field)):
                click.secho(f"Updating category {category['id']}", fg="yellow")
                self._client.update_category(
                    id=category['id'],
                    name=category["name"],
                )
                break
  
    def _sync_deleted(self, categories: list, remote_categories: list):
        categories_map = {cat["id"]: cat for cat in categories}
        for category_id, _ in remote_categories.items():
            local_category = categories_map.get(category_id)
            if not local_category:
                click.secho(f"Deleting category {category_id}", fg="red")
                self._client.delete_category(category_id)

    def sync(self, new_only: bool = False, sync_deleted: bool = False):
        categories = self._file_loader.load_categories()
        remote_categories = self._fetch_remote_categories()

        for category in categories:
            remote_category = remote_categories.get(category["id"])
            if not remote_category:
                self._create_new_category(category=category)
                continue

            if not new_only:    # sync updates of old categories
                self._update_category(category=category, remote_category=remote_category)

        if sync_deleted:
            self._sync_deleted(categories=categories, remote_categories=remote_categories)
