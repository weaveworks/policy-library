package weave.advisor.helm_chart_values_files

test_values_file_invalid {
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
          "valuesFrom": [
            {
              "name": "invalid-values-file.yaml"
            }
          ]
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}
