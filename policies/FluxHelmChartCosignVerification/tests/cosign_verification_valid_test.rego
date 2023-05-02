package weave.advisor.helm_chart_reconcile_strategy

test_cosign_verification_valid {
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
            "provider": "cosign",
          },
          "secretRef": {
            "name": "my-cosign-keys"
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
