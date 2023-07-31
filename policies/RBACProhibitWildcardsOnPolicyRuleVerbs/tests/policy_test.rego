package weave.advisor.rbac.prohibit_wildcards_policyrule_verbs

import data.weave.advisor.rbac.prohibit_wildcards_policyrule_verbs.violation

test_valid_cluster_role {
  testcase = {
    "parameters": {
      "attributes": "verbs",
      "exclude_role_name": "",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "ClusterRole",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "list-secrets"
        },
        "rules": [
          {
            "apiGroups": [
              "*"
            ],
            "resources": [
              "secrets"
            ],
            "verbs": [
              "get"
            ]
          }
        ]
      }
    }
  }

  count(violation) == 0 with input as testcase
}


test_invalid_cluster_role {
  testcase = {
    "parameters": {
      "attributes": "verbs",
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
              "secrets"
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
      "attributes": "verbs",
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
              "secrets"
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
