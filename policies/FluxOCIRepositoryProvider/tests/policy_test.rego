package weave.advisor.ocirepository_provider

import data.weave.advisor.ocirepository_provider

test_valid_provider {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "OCIRepository",
        "metadata": {
          "name": "valid-ocirepository",
        },
        "spec": {
          "provider": "AWS"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_provider {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "OCIRepository",
        "metadata": {
          "name": "invalid-ocirepository",
        },
        "spec": {
          "provider": "InvalidProvider"
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
      "exclude_label_key": "allow-invalid-provider",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "OCIRepository",
        "metadata": {
          "name": "invalid-ocirepository",
          "labels": {
            "allow-invalid-provider": "true"
          },
        },
        "spec": {
          "provider": "InvalidProvider"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "OCIRepository",
        "metadata": {
          "name": "invalid-ocirepository",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "provider": "InvalidProvider"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}