package weave.advisor.gitrepository_ref_types

import future.keywords.in
import data.weave.advisor.gitrepository_ref_types

test_single_ref_type {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "GitRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "ref": {
                        "branch": "main"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_multiple_ref_types {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "GitRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "ref": {
                        "branch": "main",
                        "semver": "^1.0.0"
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
            "exclude_namespaces": ["kube-system"],
            "exclude_label_key": "",
            "exclude_label_value": ""
        },
        "review": {
            "object": {
                "kind": "GitRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "kube-system"
                },
                "spec": {
                    "ref": {
                        "branch": "main",
                        "semver": "^1.0.0"
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
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-policy",
            "exclude_label_value": "true"
        },
        "review": {
            "object": {
                "kind": "GitRepository",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "labels": {
                        "exclude-policy": "true"
                    }
                },
                "spec": {
                    "ref": {
                        "branch": "main",
                        "semver": "^1.0.0"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}


