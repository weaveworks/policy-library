package weave.advisor.kustomization_images_requirement

test_images_enabled_required {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "images_required": true
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "flux-system"
        },
        "spec": {
          "images": [
            {
              "name": "example-image",
              "newTag": "v1.0.0"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_images_disabled_required {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "images_required": false
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "flux-system"
        },
        "spec": {}
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_images_enabled_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "images_required": true
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "flux-system"
        },
        "spec": {}
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_images_disabled_violation {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "images_required": false
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "flux-system"
        },
        "spec": {
          "images": [
            {
              "name": "example-image",
              "newTag": "v1.0.0"
            }
          ]
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
      "exclude_label_key": "allow-images",
      "exclude_label_value": "true",
      "images_required": true
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "flux-system",
          "labels": {
            "allow-images": "true"
          }
        },
        "spec": {
          "images": [
            {
              "name": "example-image",
              "newTag": "v1.0.0"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["exclude-patches"],
      "exclude_label_key": "",
      "exclude_label_value": "",
      "patches_required": false,
    },
    "review": {
      "object": {
        "apiVersion": "kustomize.toolkit.fluxcd.io/v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "exclude-patches",
        },
        "spec": {
          "images": [
            {
              "name": "example-image",
              "newTag": "v1.0.0"
            }
          ]
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
