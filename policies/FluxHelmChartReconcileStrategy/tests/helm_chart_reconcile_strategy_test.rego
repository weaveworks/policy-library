package weave.advisor.helm_chart_reconcile_strategy

test_reconcile_strategy_chart_version {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
        },
        "spec": {
          "reconcileStrategy": "ChartVersion",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_reconcile_strategy_invalid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
        },
        "spec": {
          "reconcileStrategy": "InvalidStrategy",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_reconcile_strategy_revision {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
        },
        "spec": {
          "reconcileStrategy": "Revision",
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
      "exclude_label_key": "allow-invalid-reconcile-strategy",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "labels": {
            "allow-invalid-reconcile-strategy": "true"
          },
        },
        "spec": {
          "reconcileStrategy": "InvalidStrategy",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-reconcile-strategy"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "namespace": "allow-invalid-reconcile-strategy",
        },
        "spec": {
          "reconcileStrategy": "InvalidStrategy",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

