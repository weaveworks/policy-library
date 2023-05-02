package weave.advisor.helm_chart_reconcile_strategy

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-invalid-verification",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "labels": {
            "allow-invalid-verification": "true"
          },
        },
        "spec": {
          "verify": {
            "provider": "invalid-provider",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
