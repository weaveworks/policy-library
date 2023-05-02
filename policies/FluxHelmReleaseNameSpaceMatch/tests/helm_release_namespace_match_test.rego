package weave.advisor.helm_release_namespace_match

# Test case: HelmRelease with matching storageNamespace and targetNamespace
test_namespace_match_no_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "test-helm-release",
          "namespace": "default"
        },
        "spec": {
          "storageNamespace": "matching-namespace",
          "targetNamespace": "matching-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

# Test case: HelmRelease with non-matching storageNamespace and targetNamespace
test_namespace_match_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "test-helm-release",
          "namespace": "default"
        },
        "spec": {
          "storageNamespace": "storage-namespace",
          "targetNamespace": "target-namespace"
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

# Test case: HelmRelease with excluded label
test_exclude_label_namespace_match {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "test-helm-release",
          "namespace": "default",
          "labels": {
            "exclude-me": "true"
          }
        },
        "spec": {
          "storageNamespace": "storage-namespace",
          "targetNamespace": "target-namespace"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
