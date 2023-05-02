package weave.advisor.helm_chart_source_refrence

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-sourceRef"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "namespace": "allow-invalid-sourceRef",
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
