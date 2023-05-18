package weave.advisor.kustomization_prune

test_prune_enabled_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "prune": true
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
        },
        "spec": {
          "prune": false
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_prune_enabled_compliance {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "prune": true
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
        },
        "spec": {
          "prune": true
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-non-prune",
      "exclude_label_value": "true",
      "prune": true
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "labels": {
            "allow-non-prune": "true"
          },
        },
        "spec": {
          "prune": false
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-non-prune"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "prune": true
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "allow-non-prune",
        },
        "spec": {
          "prune": false
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
