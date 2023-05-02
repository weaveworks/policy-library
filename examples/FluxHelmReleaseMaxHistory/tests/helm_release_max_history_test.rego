package weave.advisor.helm_release_max_history

import data.weave.advisor.helm_release_max_history.violation

test_valid_max_history {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "max_history": 10
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "maxHistory": 5
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_max_history {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "max_history": 10
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "maxHistory": 15
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_max_history {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "max_history": 10
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
          "maxHistory": 15
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_max_history {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "max_history": 10
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
          "maxHistory": 15
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
