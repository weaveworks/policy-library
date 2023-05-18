package weave.advisor.kustomization_source_ref_kind

test_source_ref_kind_invalid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
        },
        "spec": {
          "sourceRef": {
            "kind": "InvalidKind",
          }
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_source_ref_kind_valid {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
        },
        "spec": {
          "sourceRef": {
            "kind": "GitRepository",
          }
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
      "exclude_label_key": "allow-invalid-sourceRef",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "labels": {
            "allow-invalid-sourceRef": "true"
          },
        },
        "spec": {
          "sourceRef": {
            "kind": "InvalidKind",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-invalid-sourceRef"],
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Kustomization",
        "metadata": {
          "name": "my-kustomization",
          "namespace": "allow-invalid-sourceRef",
        },
        "spec": {
          "sourceRef": {
            "kind": "InvalidKind",
          }
        }
      }
    }
  }

  count(violation) == 0 with input as testcase
}
