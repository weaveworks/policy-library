package weave.advisor.helm_release_rollback

import data.weave.advisor.helm_release_rollback.violation

test_valid_rollback_disabled {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "rollback": {
            "enable": false
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_rollback_enabled {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "rollback": {
            "enable": true
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "rollback": {
            "enable": true
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "rollback": {
            "enable": true
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
