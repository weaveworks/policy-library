package weave.advisor.kustomization_components

import future.keywords.in
import data.weave.advisor.kustomization_components

test_no_excluded_component {
    testcase := {
        "parameters": {
            "excluded_components": ["bad-component"],
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "components": ["good-component"]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_component_present {
    testcase := {
        "parameters": {
            "excluded_components": ["bad-component"],
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "components": ["good-component", "bad-component"]
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_excluded_namespace {
    testcase := {
        "parameters": {
            "excluded_components": ["bad-component"],
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system"
                },
                "spec": {
                    "components": ["good-component", "bad-component"]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_label {
    testcase := {
        "parameters": {
            "excluded_components": ["bad-component"],
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-me",
            "exclude_label_value": "true"
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
                    "components": ["good-component", "bad-component"]
                }
            }
        }    
    }
    count(violation) == 0 with input as testcase
}
