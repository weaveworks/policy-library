package weave.advisor.rbac.prohibit_wildcards

import data.weave.advisor.rbac.prohibit_wildcards.violation

test_invalid_cluster_role {
  testcase = {
    "parameters": {
      "attributes": "resources",
      "exclude_role_name": "",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "ClusterRole",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "wildcard-resources"
        },
        "rules": [
          {
            "apiGroups": [
              "*"
            ],
            "resources": [
              "*"
            ],
            "verbs": [
              "*"
            ]
          }
        ]
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_invalid_role {
  testcase = {
    "parameters": {
      "attributes": "resources",
      "exclude_role_name": "",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "Role",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "wildcard-secrets",
          "namespace": "podinfo",
        },
        "rules": [
          {
            "apiGroups": [
              "*"
            ],
            "resources": [
              "*"
            ],
            "verbs": [
              "*"
            ]
          }
        ]
      }
    }
  }

  count(violation) == 1 with input as testcase
}
