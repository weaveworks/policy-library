package weave.advisor.helm_release_suspended_waiver

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
waiver_list := input.parameters.waiver_list

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_input.metadata.name in waiver_list
    controller_spec.suspend == true
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' must not be suspended.", [controller_input.metadata.name]),
        "violating_key": "spec.suspend"
    }
}

# Controller input
controller_input = input.review.object

# controller_spec acts as an iterator to get spec from the HelmRelease
controller_spec = controller_input.spec {
    controller_input.kind == "HelmRelease"
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
