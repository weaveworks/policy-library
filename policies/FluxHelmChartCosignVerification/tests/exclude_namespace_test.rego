package weave.advisor.helm_chart_reconcile_strategy

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-verification"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "namespace": "allow-invalid-verification",
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
