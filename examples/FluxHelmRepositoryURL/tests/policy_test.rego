package weave.advisor.helm_repo_url

import data.weave.advisor.helm_repo_url.violation

test_valid_helm_repo_url {
  testcase = {
    "parameters": {
      "domains": ["example.com"],
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
          "url": "https://example.com/charts",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_helm_repo_url {
  testcase = {
    "parameters": {
      "domains": ["example.com"],
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
          "url": "https://another-example.com/charts",
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_excluded_namespace {
  testcase = {
    "parameters": {
      "domains": ["example.com"],
      "exclude_namespaces": ["kube-system"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "invalid-helm-repo",
          "namespace": "kube-system",
        },
        "spec": {
          "url": "https://another-example.com/charts",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_excluded_label {
  testcase = {
    "parameters": {
      "domains": ["example.com"],
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRepository",
        "metadata": {
          "name": "invalid-helm-repo",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "url": "https://another-example.com/charts",
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
