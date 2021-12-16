import yaml
import requests
import click
import os

MAGALIX_ACCOUNT = "816805bb-8311-4312-afac-ef3ba41d1287"
POLICIES_SVC_URL = "http://localhost:8080/api/v1"

def _handle_api_error(response):
    if response.status_code >= 400 and response.status_code < 500:
        errors = response.json().get("errors", [])
        click.secho(f"[ERROR] {','.join(errors)}", fg="red")
        click.secho(f"[ERROR] request {response.request.method} {response.request.url}", fg="red")
    response.raise_for_status()

class PolicyServiceClient:
    def __init__(self, url: str = POLICIES_SVC_URL, magalix_account: str = MAGALIX_ACCOUNT):
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
                click.secho(f"[WARN] action is skipped, {response.json()}", fg="yellow")

        return response
    
    def create_policy(self, policy: dict):
        response = self._call_api("post", "policies", body=policy, die=False)
        if not response.ok:
            if response.status_code == 409:
                response = self.query_policies(filters={"names": policy["name"]})
                data = response.json()
                if data["count"] > 0:
                    return data["data"][0]["id"]
            else:
                _handle_api_error(response)
        return response.json()["id"]

    def update_policy(self, policy: dict):
        policy_id = policy["id"]
        return self._call_api("put", f"policies/{policy_id}", body=policy)

    def delete_policy(self, id: str):
        return self._call_api("delete", f"policies/{id}", die=False)

    def get_policy(self, id: str):
        return self._call_api("get", f"policies/{id}")

    def query_policies(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"policies/query", body=body)

    def create_template(self, template: dict):
        response = self._call_api("post", "templates", body=template, die=False)
        if not response.ok:
            if response.status_code == 409:
                response = self.query_templates(filters={"names": template["name"]})
                data = response.json()
                if data["count"] > 0:
                    return data["data"][0]["id"]
            else:
                _handle_api_error(response)
        return response.json()["id"]

    def update_template(self, template: dict):
        template_id = template["id"]
        return self._call_api("put", f"templates/{template_id}", body=template)

    def delete_template(self, id: str):
        return self._call_api("delete", f"templates/{id}", die=False)

    def get_template(self, id: str):
        return self._call_api("get", f"templates/{id}")

    def query_templates(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"templates/query", body=body)

    def create_standard(self, id: str, name: str, description: str):
        body = {"id": id, "name": name, "description": description}
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

    def update_standard(self, id: str, name: str, description: str):
        body = {"name": name, "description": description}
        return self._call_api("put", f"standards/{id}", body=body)

    def delete_standard(self, id: str):
        return self._call_api("delete", f"standards/{id}", die=False)

    def get_standard(self, id: str):
        return self._call_api("get", f"standards/{id}")

    def query_standards(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"standards/query", body=body)

    def create_control(self, id: str, name: str, description: str, order: str, standard_id: str):
        body = {
            "id": id,
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

    def update_control(self, id: str, name: str, description: str, order: str):
        body = {"name": name, "description": description, "order": str(order)}
        return self._call_api("put", f"controls/{id}", body=body)

    def delete_control(self, id: str):
        return self._call_api("delete", f"controls/{id}", die=False)

    def get_control(self, id: str):
        return self._call_api("get", f"controls/{id}")

    def query_controls(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"controls/query", body=body)

    def create_category(self, id: str, name: str):
        body = {"id": id, "name": name}
        response = self._call_api("post", "categories", body=body, die=False)
        if not response.ok:
            if response.status_code == 409:
                response = self.query_categories(filters={"names": [name]})
                data = response.json()
                if data["count"] > 0:
                    return data["data"][0]["id"]
            else:
                _handle_api_error(response)
        return response.json()["id"]

    def update_category(self, id: str, name: str):
        body = {"name": name}
        return self._call_api("put", f"categories/{id}", body=body)

    def delete_category(self, id: str):
        return self._call_api("delete", f"categories/{id}", die=False)

    def get_category(self, id: str):
        return self._call_api("get", f"categories/{id}")

    def query_categories(self, filters: dict = None, page: int = 1, limit: int = 1000):
        body = {"page": page, "limit": limit, "filters": filters}
        return self._call_api("post", f"categories/query", body=body)
