package weave.advisor.ocirepository_patch_annotation

import future.keywords.in
import data.weave.advisor.ocirepository_patch_annotation

test_patch_annotation_matches_provider {
    testcase := {
        "parameters": {
            "provider": "correct-provider",
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "annotations": {
                        "fluxcd.io/automated": "correct-provider"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_patch_annotation_does_not_match_provider {
    testcase := {
        "parameters": {
            "provider": "correct-provider",
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "annotations": {
                        "fluxcd.io/automated": "wrong-provider"
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
            "provider": "correct-provider",
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system",
                    "annotations": {
                        "fluxcd.io/automated": "wrong-provider"
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
            "provider": "correct-provider",
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-policy",
            "exclude_label_value": "true"
        },
        "review": {
            "object": {
                "kind": "OCIRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "labels": {
                        "exclude-policy": "true"
                    },
                    "annotations": {
                        "fluxcd.io/automated": "wrong-provider"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
