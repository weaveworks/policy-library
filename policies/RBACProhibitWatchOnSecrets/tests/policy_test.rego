package weave.advisor.rbac.generic_prohibit_resource_verb

import data.weave.advisor.rbac.generic_prohibit_resource_verb.violation

test_invalid_cluster_role {
  testcase = {
    "parameters": {
      "resource": "secrets",
      "verb": "watch",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "ClusterRole",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "watch-secrets"
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
              "watch"
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
      "verb": "watch",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "kind": "Role",
        "apiVersion": "rbac.authorization.k8s.io/v1",
        "metadata": {
          "name": "watch-secrets",
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
              "watch"
            ]
          }
        ]
      }
    }
  }

  count(violation) == 1 with input as testcase
}
