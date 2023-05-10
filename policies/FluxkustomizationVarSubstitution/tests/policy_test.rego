package weave.advisor.kustomization_var_substitution

import future.keywords.in
import data.weave.advisor.kustomization_var_substitution

test_var_substitution_disabled {
    testcase := {
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
                    "postBuild": {
                        "substitute": {
                            "var_substitution_enabled": false
                        }
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_var_substitution_enabled {
    testcase := {
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
                    "postBuild": {
                        "substitute": {
                            "var_substitution_enabled": true
                        }
                    }
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
                    "postBuild": {
                        "substitute": {
                            "var_substitution_enabled": true
                        }
                    }
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
                    "postBuild": {
                        "substitute": {
                            "var_substitution_enabled": true
                        }
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
