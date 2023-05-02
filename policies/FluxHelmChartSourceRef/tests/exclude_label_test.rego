package weave.advisor.helm_chart_reconcile_strategy

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-invalid-sourceRef",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "labels": {
            "allow-invalid-sourceRef": "true"
          },
        },
        "spec": {
          "sourceRef": {
            "kind": "InvalidKind",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
