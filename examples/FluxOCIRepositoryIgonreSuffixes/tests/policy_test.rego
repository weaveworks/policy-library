package weave.advisor.ocirepository_ignore_suffixes

import future.keywords.in
import data.weave.advisor.ocirepository_ignore_suffixes


test_ignore_suffixes_present {
    testcase := {
        "parameters": {
            "suffixes": [".md", ".txt"],
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
                    "ignore": "/*.md\n/*.txt"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_ignore_suffixes_missing {
    testcase := {
        "parameters": {
            "suffixes": [".md", ".txt"],
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
                    "ignore": "/*.md"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "suffixes": [".md", ".txt"],
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
                    "ignore": "/*.md"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_label {
    testcase := {
        "parameters": {
            "suffixes": [".md", ".txt"],
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
                    }
                },
                "spec": {
                    "ignore": "/*.md"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

