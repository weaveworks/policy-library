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