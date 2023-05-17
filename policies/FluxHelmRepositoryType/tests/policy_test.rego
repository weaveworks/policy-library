package weave.advisor.helm_repo_type

test_valid_helm_repo_type {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "valid-helm-repo",
        },
        "spec": {
          "type": "oci",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_helm_repo_type {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "invalid-helm-repo",
        },
        "spec": {
          "type": "invalid-type",
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
      "exclude_label_key": "allow-non-oci-repo",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "my-helm-repo",
          "labels": {
            "allow-non-oci-repo": "true"
          },
        },
        "spec": {
          "type": "non-oci",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_excluded_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "helm-repo-in-excluded-namespace",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "type": "invalid-type",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}


