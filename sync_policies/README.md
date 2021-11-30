# Policy Publish CLI
this CLI will be used to sync magalix policies in `policies-service`

## Usage

To sync magalix policies you should do the following

```
python3 ./sync.py policies --path <policy directory path> --environment <dev|prod>
```

To sync all Magalix policies you should:
```
python3 sync_policies/sync_all.py--environment <dev|prod>
```

To delete magalix templates and all of its constraints use
```
python3 sync.py delete --template_id=<template_id> --environment <dev|prod>
```

To delete magalix policy use
```
python3 sync.py delete --policy_id=<policy_id> --environment <dev|prod>
```

> **Limitations:** you can update all the values in templates or constraints **EXCEPT** their names as it's the identifier we use to update the policy

### Policy Directory Structure

└── template

    ├── code.rego

    ├── template.yaml
└── constraints

    ├── constraint1.rego

    ├── constraint2.yaml (each policy name in the `spec.yaml`)


### template.yaml
should have all required fields of advisor object **and a field `sync: true`** if it's ready to be synced
```yaml
sync: true

name: string
description: string
how_to_solve: string
category_id: uuid
severity: low|medium|high
parameters:
- name: string
  default:
  required: bool
  type: string
```

## constraint.yaml
should have all required fields of issue object **and a field `sync: true`** if it's ready to be synced

```yaml
sync: true

name: string
targets:
  {
    "kind":
      [
        "Deployment",
        "Job",
        "ReplicationController",
        "ReplicaSet",
        "DaemonSet",
        "StatefulSet",
        "CronJob",
      ],
      "cluster": []
  }
tags: []
enabled: true
parameters: {
  "probe": livenessProbe
}
```
