package weave.advisor.kustomization_target_namespace

import data.weave.advisor.kustomization_target_namespace.violation

test_valid_target_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "target_namespaces": ["allowed-namespace"]
    },
    "review": {
      "object": {
        "kind": "Kustomization",
        "metadata": {
          "name": "valid-kustomization",
        },
        "spec": {
          "targetNamespace": "allowed-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_target_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "target_namespaces": ["allowed-namespace"]
    },
    "review": {
      "object": {
        "kind": "Kustomization",
        "metadata": {
          "name": "invalid-kustomization",
        },
        "spec": {
          "targetNamespace": "disallowed-namespace"
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_target_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "target_namespaces": ["allowed-namespace"]
    },
    "review": {
      "object": {
        "kind": "Kustomization",
        "metadata": {
          "name": "invalid-kustomization",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "targetNamespace": "disallowed-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_target_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "target_namespaces": ["allowed-namespace"]
    },
    "review": {
      "object": {
        "kind": "Kustomization",
        "metadata": {
          "name": "invalid-kustomization",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "targetNamespace": "disallowed-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
