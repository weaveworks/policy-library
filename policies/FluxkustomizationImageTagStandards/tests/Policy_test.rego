package weave.advisor.kustomization_image_tag_standards

import future.keywords.in
import data.weave.advisor.kustomization_image_tag_standards

test_valid_image_tag {
    input := {
        "parameters": {
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
                    "images": [
                        {
                            "name": "podinfo",
                            "newTag": "v1.0.0"
                        }
                    ]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_invalid_image_tag {
    input := {
        "parameters": {
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
                    "images": [
                        {
                            "name": "podinfo",
                            "newTag": "invalid-tag"
                        }
                    ]
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_excluded_namespace {
    input := {
        "parameters": {
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
                    "images": [
                        {
                            "name": "podinfo",
                            "newTag": "invalid-tag"
                        }
                    ]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_label {
    input := {
        "parameters": {
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
                    "images": [
                        {
                            "name": "podinfo",
                            "newTag": "invalid-tag"
                        }
                    ]
                }
            }
        }    
    }
    count(violation) == 0 with input as testcase
}
