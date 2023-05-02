package weave.advisor.helm_release_post_renderer

import data.weave.advisor.helm_release_post_renderer.violation

test_valid_no_post_renderer {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "valid-helm-release",
        },
        "spec": {
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_post_renderer_enabled {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "invalid-helm-release",
        },
        "spec": {
          "postRenderers": ["some-renderer"]
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_exclude_label_post_renderer_enabled {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "exclude",
      "exclude_label_value": "true"
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "labels": {
            "exclude": "true"
          }
        },
        "spec": {
          "postRenderers": ["some-renderer"]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace_post_renderer_enabled {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["excluded-namespace"],
      "exclude_label_key": "",
      "exclude_label_value": ""
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "HelmRelease",
        "metadata": {
          "name": "excluded-helm-release",
          "namespace": "excluded-namespace",
        },
        "spec": {
          "postRenderers": ["some-renderer"]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
