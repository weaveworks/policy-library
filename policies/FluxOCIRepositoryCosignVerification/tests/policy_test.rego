package weave.advisor.ocirepository_cosign_verification

test_cosign_verification_invalid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "OCIRepository",
        "metadata": {
          "name": "my-oci-repository",
        },
        "spec": {
          "verify": {
            "provider": "invalid-provider",
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_cosign_verification_valid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "OCIRepository",
        "metadata": {
          "name": "my-oci-repository",
        },
        "spec": {
          "verify": {
            "provider": "cosign",
            "secretRef": {
              "name": "my-cosign-keys"
            }
          }
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
      "exclude_label_key": "allow-invalid-verification",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "OCIRepository",
        "metadata": {
          "name": "my-oci-repository",
          "labels": {
            "allow-invalid-verification": "true"
          },
        },
        "spec": {
          "verify": {
            "provider": "invalid-provider",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-verification"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "OCIRepository",
        "metadata": {
          "name": "my-oci-repository",
          "namespace": "allow-invalid-verification",
        },
        "spec": {
          "verify": {
            "provider": "invalid-provider",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}