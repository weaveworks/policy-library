package weave.advisor.kustomization_reconcile_interval

import future.keywords.in
import data.weave.advisor.kustomization_reconcile_interval

# Test cases for valid reconcile interval
test_valid_reconcile_interval {
    input := {
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
                    "interval": "5m"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

# Test cases for reconcile interval too low
test_reconcile_interval_too_low {
    input := {
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

# Test cases for reconcile interval too high
test_reconcile_interval_too_high {
    input := {
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

# Test cases for exclude namespace
test_exclude_namespace {
    input := {
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

# Test cases for exclude label
test_exclude_label {
    input := {
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
    count
