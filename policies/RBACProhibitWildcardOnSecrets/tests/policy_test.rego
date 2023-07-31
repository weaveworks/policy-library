package weave.advisor.rbac.prohibit_wildcard_secrets

import data.weave.advisor.rbac.prohibit_wildcard_secrets.violation

test_valid_cluster_role {
  testcase = {
    "parameters": {
      "resource": "secrets",
      "verb": "list",
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
      "resource": "secrets",
      "verb": "*",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "ClusterRole",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "wildcard-secrets"
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
      "resource": "secrets",
      "verb": "*",
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
