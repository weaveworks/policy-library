package weave.advisor.kustomization_reconcile_interval

import future.keywords.in
import data.weave.advisor.kustomization_reconcile_interval

test_valid_reconcile_interval {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 60,
            "upper_bound": 600
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "interval": 300 
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}


test_reconcile_interval_too_low {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 60,
            "upper_bound": 600
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "interval": "30s"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_reconcile_interval_too_high {
    testcase := {
        "parameters": {
            "exclude_namespaces": [],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 60,
            "upper_bound": 600
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default"
                },
                "spec": {
                    "interval": "15m"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "exclude_namespaces": ["excluded-namespace"],
            "exclude_label_key": "",
            "exclude_label_value": "",
            "lower_bound": 60,
            "upper_bound": 600
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "excluded-namespace"
                },
                "spec": {
                    "interval": "30s"
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
            "exclude_label_value": "true",
            "lower_bound": 60,
            "upper_bound": 600
        },
        "review": {
            "object": {
                "kind": "Kustomization",
                "metadata": {
                    "name": "example",
                    "namespace": "default",
                    "labels": {
                        "exclude-policy": "true"
                    }
                },
                "spec": {
                    "interval": "30s"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
