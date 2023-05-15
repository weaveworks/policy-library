package weave.advisor.gitrepository_ref_types

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    ref := controller_spec.ref
    not is_single_ref_type(ref)
    result = {
        "issue detected": true,
        "msg": sprintf("The GitRepository '%s' must use only one of (branch, semver, commit). Multiple reference types found.", [controller_input.metadata.name]),
        "violating_key": "spec.ref"
    }
}

is_single_ref_type(ref) {
    count([k | ref[k]]) == 1
}

controller_input = input.review.object

controller_spec = controller_input.spec {
    controller_input.kind == "GitRepository"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
