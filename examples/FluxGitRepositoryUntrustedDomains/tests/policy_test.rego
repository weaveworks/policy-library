package weave.advisor.gitrepository_untrusted_domains

import future.keywords.in
import data.weave.advisor.gitrepository_untrusted_domains

test_untrusted_domain {
    testcase := {
        "parameters": {
            "untrusted_domains": ["github.com"],
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
                    "url": "https://github.com/untrusted-org/repo"
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}


test_trusted_domain {
    testcase := {
        "parameters": {
            "untrusted_domains": ["github.com/untrusted-org"],
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
                    "url": "https://github.com/trusted-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "untrusted_domains": ["github.com/untrusted-org"],
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
                    "url": "https://github.com/untrusted-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_label {
    testcase := {
        "parameters": {
            "untrusted_domains": ["github.com/untrusted-org"],
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
                    "url": "https://github.com/untrusted-org/repo"
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
