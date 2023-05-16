package weave.advisor.resource_labels_annotations

import data.weave.advisor.resource_labels_annotations

test_valid_resource {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-resource",
          "labels": {
            "app": "my-app",
          },
          "annotations": {
            "version": "1.0",
          },
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_resource_missing_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-resource",
          "labels": {},
          "annotations": {
            "version": "1.0",
          },
        },
        "spec": {}
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_invalid_resource_missing_annotation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-resource",
          "labels": {
            "app": "my-app",
          },
          "annotations": {},
        },
        "spec": {}
      }
    }
  }

  count(violation) == 1 with input as testcase
}

# test_valid_gitrepository to demonstrates that the policy works correctly with different kinds of resources.

test_valid_gitrepository {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "GitRepository",
        "metadata": {
          "name": "valid-gitrepository",
          "labels": {
            "app": "my-app",
          },
          "annotations": {
            "version": "1.0",
          },
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_label_resource {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-resource",
          "labels": {
            "exclude-me": "true",
          },
          "annotations": {},
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_resource {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "labels": [{"key": "app", "value": "my-app"}],
      "annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-resource",
          "namespace": "excluded-namespace",
          "labels": {},
          "annotations": {},
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}


