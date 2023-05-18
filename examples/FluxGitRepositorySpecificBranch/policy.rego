package weave.advisor.gitrepository_specific_branch

import future.keywords.in

branch := input.parameters.branch
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    repo_ref := controller_spec.ref.branch
    repo_ref != branch
    result = {
        "issue detected": true,
        "msg": sprintf("The GitRepository '%s' must reference the specific branch '%s'. Found: '%s'", [controller_input.metadata.name, branch, repo_ref]),
        "violating_key": "spec.ref.branch"
    }
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
