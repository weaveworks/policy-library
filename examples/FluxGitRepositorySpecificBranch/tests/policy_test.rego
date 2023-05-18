package weave.advisor.gitrepository_specific_branch

import future.keywords.in
import data.weave.advisor.gitrepository_specific_branch.violation

test_correct_branch {
    testcase := {
        "parameters": {
            "branch": "main",
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

test_wrong_branch {
    testcase := {
        "parameters": {
            "branch": "main",
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
                        "branch": "dev"
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
            "branch": "main",
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
                        "branch": "dev"
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
            "branch": "main",
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
                        "branch": "dev"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
