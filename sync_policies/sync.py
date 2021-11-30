#!/usr/bin/python3

import click
import file_walker
import yaml
import requests
import os
import glob

MAGALIX_ACCOUNT = "816805bb-8311-4312-afac-ef3ba41d1287"
policies_url = "http://policies-service.cluster-advisor.svc/api/v1"

STANDARDS_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "Standards")

def _get_control_map():
    controls_map = {}
    files = glob.glob(f"{STANDARDS_DIR}/**/*yaml")
    for path in files:
        with open(path, "r") as f:
            data = yaml.safe_load(f)
            for control in data.get("controls", []):
                if control.get("id"):
                    controls_map[control["id"]] = {
                        "dev": control.get("dev_id", None),
                        "prod": control.get("prod_id", None)
                    }
    return controls_map

@click.group()
def sync():
    pass


@sync.command()
@click.option(
    "--template_id",
    help="will delete template and all its constraints",
)
@click.option("--policy_id", help="will delete policy")
def delete(template_id, policy_id):
    if template_id is not None:
        # delete template's constraints if found
        constraint_filters = {"template_ids": [template_id]}
        headers = {"X-ACCOUNT": MAGALIX_ACCOUNT}

        response = requests.post(
            policies_url + "/constraints/query",
            json={"filters": constraint_filters, "limit": 1000},
            headers=headers,
        )

        if response.status_code != 200:
            raise Exception("failed to query constraints")

        template_policies = response.json()["data"]
        for policy in template_policies:
            response = requests.delete(
                policies_url + "/constraints/" + policy["id"],
                headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
            )
            if response.status_code != 204:
                raise Exception("failed to delete constraints %d" % response.status_code)

        response = requests.delete(
            policies_url + "/templates/" + template_id,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )

        if response.status_code != 204:
            raise Exception("failed to delete template")
    elif policy_id is not None:
        response = requests.delete(
            policies_url + "/constraints/" + policy_id,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )
        if response.status_code != 204:
            raise Exception("failed to delete constraints")


@sync.command()
@click.option(
    "--path", default="../policy_example", help="directory that contains the policy"
)
@click.option(
    "--environment", required=True, type=click.Choice(['dev', 'prod']), help="environment name"
)
def policies(path, environment):
    policies = _get_policies(path)
    if len(policies) == 0:
        print("policy is not found. path: " + path)
        return

    template_id = _upsert_template(environment, policies["template"])
    for constraint in policies["constraints"]:
        _upsert_constraint(template_id, constraint)


def _upsert_template(
    environment, template=None, policies_url="http://policies-service.cluster-advisor.svc/api/v1"
):

    if not template.get("provider"):
        template["provider"] = "kubernetes"

    if template.get("ids"):
        template_filters = {"ids": template["ids"]}
    else:
        template_filters = {"names": [template["name"]]}


    env_controls = []
    controls_map = _get_control_map()
    if template.get("controls", []):
        for control in template["controls"]:
            if controls_map.get(control):
                if controls_map[control].get(environment):
                    env_controls.append(controls_map[control][environment])

    template["controls"] = env_controls

    headers = {"X-ACCOUNT": MAGALIX_ACCOUNT}
    response = requests.post(
        policies_url + "/templates/query",
        json={"filters": template_filters, "limit": 1000},
        headers=headers,
    )
    if response.status_code != 200:
        raise Exception("failed to get template: ", response.json())

    data = response.json().get("data")

    if template.get("ids") and len(data) == 0:
        template_filters = {"names": [template["name"]]}
        headers = {"X-ACCOUNT": MAGALIX_ACCOUNT}
        response = requests.post(
            policies_url + "/templates/query",
            json={"filters": template_filters, "limit": 1000},
            headers=headers,
        )
        if response.status_code != 200:
            raise Exception("failed to get template")
        data = response.json().get("data")

    if data is not None and len(data) > 0:
        template_id = data[0]["id"]
        response = requests.put(
            policies_url + "/templates/" + template_id,
            json=template,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )

        if response.status_code != 204:
            raise Exception("failed to update template", response.json())
    else:
        response = requests.post(
            policies_url + "/templates",
            json=template,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )

        if response.status_code != 201:
            raise Exception("failed to create template", response.json())
        template_id = response.json()["id"]
    ids = template.get("ids", [])
    if template_id not in ids:
        with open(template["ids_path"], "w") as td:
            ids.append(template_id)
            td.write("\n".join(ids))
    return template_id


def _upsert_constraint(
    template_id,
    constraint=None,
    policies_url="http://policies-service.cluster-advisor.svc/api/v1",
):
    constraint["template_id"] = template_id

    if (
        not constraint.get("targets")
        or not constraint["targets"].get("kind")
        or constraint["targets"]["kind"] == []
    ):
        raise Exception(
            "constraint: {"
            + constraint["name"]
            + "} must have kind set to value; for example 'kind: [Deployment]'"
        )

    targets = {
        "kind": [],
        "cluster": [],
        "namespace": [],
        "label": [],
    }
    targets.update(constraint["targets"])
    constraint["targets"] = targets

    if constraint.get("ids"):
        constraint_filters = {"ids": constraint["ids"]}
    else:
        constraint_filters = {"names": [constraint["name"]]}
    headers = {"X-ACCOUNT": MAGALIX_ACCOUNT}
    response = requests.post(
        policies_url + "/constraints/query",
        json={"filters": constraint_filters, "limit": 1000},
        headers=headers,
    )

    if response.status_code != 200:
        raise Exception("failed to get constraint")

    data = response.json().get("data")
    if constraint.get("ids") and (data is None or len(data) == 0):
        constraint_filters = {"names": [constraint["name"]]}
        headers = {"X-ACCOUNT": MAGALIX_ACCOUNT}
        response = requests.post(
            policies_url + "/constraints/query",
            json={"filters": constraint_filters, "limit": 1000},
            headers=headers,
        )

        if response.status_code != 200:
            raise Exception("failed to get constraint")

        data = response.json().get("data")

    if data is not None and len(data) > 0:
        constraint_id = data[0]["id"]
        response = requests.put(
            policies_url + "/constraints/" + constraint_id,
            json=constraint,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )

        if response.status_code != 204:
            raise Exception("failed to update constraint", response.json())
    else:
        response = requests.post(
            policies_url + "/constraints",
            json=constraint,
            headers={"X-ACCOUNT": MAGALIX_ACCOUNT},
        )

        if response.status_code != 201:
            raise Exception("failed to create constraint", response.json())
        constraint_id = response.json()["id"]

    ids = constraint.get("ids", [])
    if constraint_id not in ids:
        with open(constraint["ids_path"], "w") as cd:
            ids.append(constraint_id)
            cd.write("\n".join(ids))


def _get_policies(path):
    policy = {
        "constraints": [],
    }

    for f in file_walker.walk(path):
        if f.isDirectory and f.name == "template":
            template = {}
            for sub_f in f.walk():
                if sub_f.isFile and sub_f.extension == ".yaml":
                    with sub_f.open("r") as t:
                        tmp_template = yaml.load(t, Loader=yaml.FullLoader)
                        if tmp_template["sync"]:
                            if template.get("code"):
                                tmp_template["code"] = template["code"]
                            ids_path = "{0}_ids.txt".format(
                                *os.path.splitext(sub_f.full_path)
                            )
                            ids = []
                            if os.path.exists(ids_path):
                                with open(ids_path, "r") as fi:
                                    ids = [id.rstrip() for id in fi]
                            tmp_template["ids_path"] = ids_path
                            tmp_template["ids"] = ids
                            template = tmp_template
                        else:
                            return {}
                elif sub_f.isFile and sub_f.extension == ".rego":
                    with open(sub_f.full_path, "r") as policy_code:
                        template["code"] = policy_code.read()
                policy["template"] = template
        elif f.isDirectory and f.name == "constraints":
            for sub_f in f.walk():
                if sub_f.isFile and sub_f.extension == ".yaml":
                    with sub_f.open("r") as cf:
                        constraint = yaml.load(cf, Loader=yaml.FullLoader)
                    ids_path = "{0}_ids.txt".format(*os.path.splitext(sub_f.full_path))
                    ids = []
                    if os.path.exists(ids_path):
                        with open(ids_path, "r") as fi:
                            ids = [id.rstrip() for id in fi]
                    constraint["ids_path"] = ids_path
                    constraint["ids"] = ids
                    policy["constraints"].append(constraint)
    return policy


if __name__ == "__main__":
    sync()
