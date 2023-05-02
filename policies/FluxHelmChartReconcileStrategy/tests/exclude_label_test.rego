package weave.advisor.helm_chart_reconcile_strategy

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
