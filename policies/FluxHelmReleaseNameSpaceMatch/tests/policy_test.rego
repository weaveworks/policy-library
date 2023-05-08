package weave.advisor.helm_release_namespace_match

test_namespace_match_valid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "my-helm-release",
        },
        "spec": {
          "storageNamespace": "matching-namespace",
          "targetNamespace": "matching-namespace",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_namespace_match_invalid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "my-helm-release",
        },
        "spec": {
          "storageNamespace": "storage-namespace",
          "targetNamespace": "target-namespace",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "allow-namespace-mismatch",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "my-helm-release",
          "labels": {
            "allow-namespace-mismatch": "true"
          },
        },
        "spec": {
          "storageNamespace": "storage-namespace",
          "targetNamespace": "target-namespace",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-namespace-mismatch"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "my-helm-release",
          "namespace": "allow-namespace-mismatch",
        },
        "spec": {
          "storageNamespace": "storage-namespace",
          "targetNamespace": "target-namespace",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
