package weave.advisor.ocirepository_layer_selector

import future.keywords.in
import data.weave.advisor.ocirepository_layer_selector

test_predefined_media_and_operation {
    testcase := {
        "parameters": {
            "media_types": ["application/deployment.content.v1.tar+gzip"],
            "operations": ["extract", "copy"],
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "layerSelector": {
                        "mediaType": "application/deployment.content.v1.tar+gzip",
                        "operation": "extract"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_non_predefined_media {
    testcase := {
        "parameters": {
            "media_types": ["application/deployment.content.v1.tar+gzip"],
            "operations": ["extract", "copy"],
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "layerSelector": {
                        "mediaType": "application/non-predefined.media",
                        "operation": "extract"
                    }
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_non_predefined_operation {
    testcase := {
        "parameters": {
            "media_types": ["application/deployment.content.v1.tar+gzip"],
            "operations": ["extract", "copy"],
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "layerSelector": {
                        "mediaType": "application/deployment.content.v1.tar+gzip",
                        "operation": "non-predefined-operation"
                    }
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "media_types": ["application/deployment.content.v1.tar+gzip"],
            "operations": ["extract", "copy"],
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system"
                },
                "spec": {
                    "layerSelector": {
                        "mediaType": "application/non-predefined.media",
                        "operation": "extract"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_label {
    testcase := {
        "parameters": {
            "media_types": ["application/deployment.content.v1.tar+gzip"],
            "operations": ["extract", "copy"],
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-policy",
            "exclude_label_value": "true"
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system",
                    "labels": {
                        "exclude-policy": "true"
                    }
                },
                "spec": {
                    "layerSelector": {
                        "mediaType": "application/deployment.content.v1.tar+gzip",
                        "operation": "extract"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
