package weave.advisor.bucket_approved_region

import data.weave.advisor.bucket_approved_region.violation

test_valid_bucket_region {
  testcase = {
    "parameters": {
      "regions": ["us-west-2", "us-east-1"],
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
          "region": "us-west-2"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_bucket_region {
  testcase = {
    "parameters": {
      "regions": ["us-west-2", "us-east-1"],
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
          "region": "eu-west-1"
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label {
  testcase = {
    "parameters": {
      "regions": ["us-west-2", "us-east-1"],
      "exclude_namespaces": [],
      "exclude_label_key": "allow-invalid-region",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "Bucket",
        "metadata": {
          "name": "invalid-bucket",
          "labels": {
            "allow-invalid-region": "true"
          },
        },
        "spec": {
          "region": "eu-west-1"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "regions": ["us-west-2", "us-east-1"],
      "exclude_namespaces": ["allow-invalid-region"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "source.toolkit.fluxcd.io/v1beta2",
        "kind": "Bucket",
        "metadata": {
          "name": "invalid-bucket",
          "namespace": "allow-invalid-region",
        },
        "spec": {
          "region": "eu-west-1"
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
