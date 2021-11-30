#!/usr/bin/python3

import click
import os
from exclude import excluded_dirs
from sync import _get_policies, _upsert_template, _upsert_constraint


@click.command()
@click.option("--path", default=".", help="directory that contains the policy")
@click.option("--environment", required=True, type=click.Choice(['dev', 'prod']), help="environment name")
@click.option("--policies_service", default="http://policies-service.cluster-advisor.svc/api/v1", help="policies service url")
def sync_all(path, environment, policies_service):
    dirs = [dir for dir in os.listdir(path) if dir not in excluded_dirs]
    for dir in dirs:
        print("syncing %s..." % dir)
        p = os.path.join(path, dir)
        _policies(p, environment, policies_service)


def _policies(path, environment, policies_url="http://policies-service.cluster-advisor.svc/api/v1"):
    policies = _get_policies(path)
    if len(policies) == 0:
        print("policy is not synced. path: " + path)
        return

    template_id = _upsert_template(environment, policies["template"], policies_url)
    for constraint in policies["constraints"]:
        _upsert_constraint(template_id, constraint, policies_url)


if __name__ == "__main__":
    sync_all()
