package weave.advisor.bucket_insecure_connections

test_insecure_connection_violation {
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
          "name": "insecure-bucket",
        },
        "spec": {
          "insecure": true
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_secure_connection_no_violation {
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
          "name": "secure-bucket",
        },
        "spec": {
          "insecure": false
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
      "exclude_label_key": "allow-insecure-connections",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "Bucket",
        "metadata": {
          "name": "insecure-bucket",
          "labels": {
            "allow-insecure-connections": "true"
          },
        },
        "spec": {
          "insecure": true
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-insecure-connections"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "Bucket",
        "metadata": {
          "name": "insecure-bucket",
          "namespace": "allow-insecure-connections",
        },
        "spec": {
          "insecure": true
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
