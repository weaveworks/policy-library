package weave.advisor.kustomization_excluded_paths

import future.keywords.in
import data.weave.advisor.kustomization_excluded_paths

test_valid_path {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "excluded_paths": ["/forbidden"]
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "path": "/allowed"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_path {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "excluded_paths": ["/forbidden"]
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "path": "/forbidden"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_excluded_namespace {
    testcase := {
        "parameters": {
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "excluded_paths": ["/forbidden"]
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system"
                },
                "spec": {
                    "path": "/forbidden"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_label {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-me",
            "exclude_label_value": "true",
            "excluded_paths": ["/forbidden"]
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "labels": {
                        "exclude-me": "true"
                    }
                },
                "spec": {
                    "path": "/forbidden"
                }
            }
        }    
    }
    count(violation) == 0 with input as testcase
}
