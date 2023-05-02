package weave.advisor.helm_chart_values_files

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-values-file"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "namespace": "allow-invalid-values-file",
        },
        "spec": {
          "valuesFrom": [
            {
              "name": "invalid-values-file.yaml"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
