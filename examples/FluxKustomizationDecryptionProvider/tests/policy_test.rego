package weave.advisor.kustomization_decryption_provider

import future.keywords.in
import data.weave.advisor.kustomization_decryption_provider

test_valid_decryption_provider {
    testcase := {
      "parameters": {
            "decryption_providers": ["sops", "mozilla-sops"],
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
                    "decryption": {
                        "provider": "sops"
                    }
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_invalid_decryption_provider {
    testcase := {
      "parameters": {
            "decryption_providers": ["sops", "mozilla-sops"],
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
                    "decryption": {
                        "provider": "invalid-provider"
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
            "decryption_providers": ["sops", "mozilla-sops"],
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
                    "decryption": {
                        "provider": "invalid-provider"
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
            "decryption_providers": ["sops", "mozilla-sops"],
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
                    "decryption": {
                        "provider": "invalid-provider"
                    }
                }
            }
        }    
    }
    count(violation) == 0 with input as testcase
}
