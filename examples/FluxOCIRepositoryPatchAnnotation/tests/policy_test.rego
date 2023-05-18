package weave.advisor.ocirepository_patch_annotation

import future.keywords.in
import data.weave.advisor.ocirepository_patch_annotation

test_patch_annotation_matches_provider {
    testcase := {
        "parameters": {
            "provider": "aws",
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
                    "patches": [{
                        "patch": "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  annotations:\n    eks.amazonaws.com/role-arn: <role arn>"
                    }]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_patch_annotation_does_not_match_provider {
    testcase := {
        "parameters": {
            "provider": "aws",
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
                    "patches": [{
                        "patch": "some different patch"
                    }]
                }
            }
        }
    }
    count(violation) == 1 with input as testcase
}

test_exclude_namespace {
    testcase := {
        "parameters": {
            "provider": "aws",
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
                    "patches": [{
                        "patch": "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  annotations:\n    eks.amazonaws.com/role-arn: <role arn>"
                    }]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}

test_exclude_label {
    testcase := {
        "parameters": {
            "provider": "aws",
            "exclude_namespaces": [],
            "exclude_label_key": "exclude-policy",
            "exclude_label_value": "true"
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
                    "patches": [{
                        "patch": "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: source-controller\n  annotations:\n    eks.amazonaws.com/role-arn: <role arn>"
                    }]
                }
            }
        }
    }
    count(violation) == 0 with input as testcase
}
