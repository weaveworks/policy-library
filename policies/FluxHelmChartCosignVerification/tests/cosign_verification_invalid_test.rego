package weave.advisor.helm_chart_reconcile_strategy

test_cosign_verification_invalid {
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
          "verify": {
            "provider": "invalid-provider",
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}
