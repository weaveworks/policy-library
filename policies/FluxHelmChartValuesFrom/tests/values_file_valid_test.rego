package weave.advisor.helm_chart_values_files

test_values_file_valid {
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
              "name": "my-values=values.yaml"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
