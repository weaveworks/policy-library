package weave.advisor.helm_release_storage_namespace

import data.weave.advisor.helm_release_storage_namespace.violation

test_valid_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "hostnames": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "chart": {
            "spec": {
              "storageNamespace": "allowed-storage-namespace"
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "hostnames": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "chart": {
            "spec": {
              "storageNamespace": "disallowed-storage-namespace"
            }
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "hostnames": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "chart": {
            "spec": {
              "storageNamespace": "disallowed-storage-namespace"
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_storage_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "hostnames": ["allowed-storage-namespace"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "chart": {
            "spec": {
              "storageNamespace": "disallowed-storage-namespace"
            }
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
