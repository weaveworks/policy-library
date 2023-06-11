package weave.advisor.resource_reconcile_interval

import data.weave.advisor.resource_reconcile_interval.violation

test_valid_reconcile_interval {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 30,
      "upper_bound": 300,
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
          "interval": "1m",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_reconcile_interval_lower_bound {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 30,
      "upper_bound": 300,
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "interval": "20s",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_invalid_reconcile_interval_upper_bound {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 30,
      "upper_bound": 300,
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "interval": "7m",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_excluded_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["kube-system"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "lower_bound": 30,
      "upper_bound": 300,
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
          "interval": "7m",
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
      "lower_bound": 30,
      "upper_bound": 300,
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "labels": {
            "exclude-me": "true",
          },
        },
        "spec": {
          "interval": "7m",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
