package weave.advisor.helm_release_name_regex

import data.weave.advisor.helm_release_name_regex.violation

test_valid_helm_release_name {
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
          "name": "abcdefghijkl-mnopqrstuvwx",
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_helm_release_name {
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
          "name": "invalid-helm-release",
        },
        "spec": {}
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_helm_release_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_helm_release_name {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}
