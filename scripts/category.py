
import click
from client import PolicyServiceClient

categories = [
    {
        'id': 'magalix.categories.organizational-standards',
        'name': 'Organizational Standards'
    },
    {
        'id': 'magalix.categories.software-supply-chain',
        'name': 'Software Supply Chain'
    },
    {
        'id': 'magalix.categories.observability',
        'name': 'Observability'
    },
    {
        'id': 'magalix.categories.data-protection',
        'name': 'Data Protection'
    },
    {
        'id': 'magalix.categories.pod-security',
        'name': 'Pod Security'
    },
    {
        'id': 'magalix.categories.network-security',
        'name': 'Network Security'
    },
    {
        'id': 'magalix.categories.access-control',
        'name': 'Access Control'
    },
    {
        'id': 'magalix.categories.reliability',
        'name': 'Reliability'
    },
    {
        'id': 'magalix.categories.capacity-management',
        'name': 'Capacity Management'
    },
    {
        'id': 'magalix.categories.best-practices',
        'name': 'Best Practices'
    },
    {
        'id': 'magalix.categories.cost-saving',
        'name': 'Cost Saving'
    },
    {
        'id': 'magalix.categories.security',
        'name': 'Security'
    },
    {
        'id': 'magalix.categories.performance',
        'name': 'Performance'
    }
]

class CategorySyncer:
    def __init__(self, policies_service: str, magalix_account: str):
        self._client = PolicyServiceClient(url=policies_service, magalix_account=magalix_account)

    def _check_required_fields(self, category: dict):
        for field in ["id", "name"]:
            if not category.get(field):
                raise Exception(f"[ERROR] Could not sync category; Missing {field} field.")

    def _fetch_remote_categories(self):
        response = self._client.query_categories(filters={"magalix": True})
        remote_categories = {cat["id"]: cat for cat in response.json()["data"]}
        return remote_categories

    def _create_new_category(self, category: dict):
        click.secho(f"Creating category {category['name']}", fg="green")
        category_id = self._client.create_category(
            id=category["id"],
            name=category["name"],
        )
    
    def _update_category(self, category: dict, remote_category: dict):
        for field in ["id", "name"]:
            if str(category[field]).strip() != str(remote_category[field]).strip():
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
        remote_categories = self._fetch_remote_categories()
        for category in categories:
            self._check_required_fields(category=category)
            remote_category = remote_categories.get(category["id"])
            if not remote_category:
                self._create_new_category(category=category)
                continue

            if not new_only:    # sync updates of old categories
                self._update_category(category=category, remote_category=remote_category)

        if sync_deleted:
            self._sync_deleted(categories=categories, remote_categories=remote_categories)
