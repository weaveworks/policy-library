package weave.advisor.bucket_provider

import data.weave.advisor.bucket_provider.violation

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
        "kind": "Bucket",
        "metadata": {
          "name": "valid-bucket",
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
        "kind": "Bucket",
        "metadata": {
          "name": "invalid-bucket",
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
        "kind": "Bucket",
        "metadata": {
          "name": "invalid-bucket",
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
        "kind": "Bucket",
        "metadata": {
          "name": "invalid-bucket",
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
