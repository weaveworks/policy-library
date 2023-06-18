package weave.advisor.helm_release_service_account_name

import data.weave.advisor.helm_release_service_account_name.violation

test_valid_service_account_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "service_account_names": ["valid-sa"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "serviceAccountName": "valid-sa"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_service_account_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "service_account_names": ["valid-sa"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "serviceAccountName": "invalid-sa"
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_undefined_service_account_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "service_account_names": ["valid-sa"]
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_service_account_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
      "service_account_names": ["valid-sa"]
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
          "serviceAccountName": "invalid-sa"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_service_account_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "service_account_names": ["valid-sa"]
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
          "serviceAccountName": "invalid-sa"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
