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
