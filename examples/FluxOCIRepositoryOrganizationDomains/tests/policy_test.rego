package weave.advisor.ocirepository_organization_domains

import future.keywords.in
import data.weave.advisor.ocirepository_organization_domains

test_allowed_domain {
    testcase := {
        "parameters": {
            "domains": ["github.com"],
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
                    "url": "https://github.com/allowed-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_disallowed_domain {
    testcase := {
        "parameters": {
            "domains": ["github.com/allowed-org"],
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
                    "url": "https://github.com/disallowed-org/repo"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "domains": ["github.com/allowed-org"],
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
                    "url": "https://github.com/disallowed-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_label {
    testcase := {
        "parameters": {
            "domains": ["github.com/allowed-org"],
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
                    "url": "https://github.com/disallowed-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
