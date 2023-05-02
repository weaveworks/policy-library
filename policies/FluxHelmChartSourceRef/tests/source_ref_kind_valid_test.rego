package weave.advisor.helm_chart_source_refrence

test_source_ref_kind_valid {
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
          "sourceRef": {
            "kind": "HelmRepository",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
