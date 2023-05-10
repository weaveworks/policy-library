package weave.advisor.kustomization_kubeconfig

import future.keywords.in
import data.weave.advisor.kustomization_kubeconfig

test_valid_kubeconfig {
    input := {
        "parameters": {
            "excluded_clusters": ["restricted-cluster"],
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
                    "kubeConfig": "unrestricted-cluster"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_invalid_kubeconfig {
    input := {
        "parameters": {
            "excluded_clusters": ["restricted-cluster"],
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
                    "kubeConfig": "restricted-cluster"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_excluded_namespace {
    input := {
        "parameters": {
            "excluded_clusters": ["restricted-cluster"],
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
                    "kubeConfig": "restricted-cluster"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_excluded_label {
    input := {
        "parameters": {
            "excluded_clusters": ["restricted-cluster"],
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
                    "kubeConfig": "restricted-cluster"
                }
            }
        }    
    }
    count(violation) == 0 with input as testcase
}
