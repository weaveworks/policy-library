package weave.advisor.helm_release_labels_annotations

import data.weave.advisor.helm_release_labels_annotations.violation

test_valid_helm_release {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "required_labels": [{"key": "app", "value": "my-app"}],
      "required_annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
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

test_invalid_helm_release_missing_label {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "required_labels": [{"key": "app", "value": "my-app"}],
      "required_annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
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

test_invalid_helm_release_missing_annotation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "required_labels": [{"key": "app", "value": "my-app"}],
      "required_annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
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

test_exclude_label_helm_release {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude-me",
      "exclude_label_value": "true",
      "required_labels": [{"key": "app", "value": "my-app"}],
      "required_annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
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

test_exclude_namespace_helm_release {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "required_labels": [{"key": "app", "value": "my-app"}],
      "required_annotations": [{"key": "version", "value": "1.0"}],
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
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
