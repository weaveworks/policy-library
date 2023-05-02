package weave.advisor.helm_chart_values_files

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-invalid-values-file",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmChart",
        "metadata": {
          "name": "my-helm-chart",
          "labels": {
            "allow-invalid-values-file": "true"
          },
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
