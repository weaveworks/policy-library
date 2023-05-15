package weave.advisor.resource_suspended_waiver

import data.weave.advisor.resource_suspended_waiver.violation

test_valid_resource_not_suspended {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "waiver_list": [],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "suspend": false,
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_resource_suspended {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "waiver_list": [],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "suspend": true,
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_valid_resource_suspended_waiver {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "waiver_list": ["waived-helm-release"],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "waived-helm-release",
        },
        "spec": {
          "suspend": true,
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_excluded_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["kube-system"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "waiver_list": [],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "namespace": "kube-system",
        },
        "spec": {
          "suspend": true,
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
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true",
      "waiver_list": [],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-suspended-helm-release",
          "labels": {
            "exclude-me": "true",
          },
        },
        "spec": {
          "suspend": true,
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
