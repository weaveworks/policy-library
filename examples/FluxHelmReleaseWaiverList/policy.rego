package helm_release_suspended_waiver

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
waiver_list := input.parameters.waiver_list

violation[result] {
    not isExcludedNamespace
    not controller_input.metadata.name in waiver_list
    controller_input.spec.suspend == true
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' cannot be suspended unless it's on the waiver list.", [controller_input.metadata.name]),
        "violating_key": "spec.suspend"
    }
}

# Controller input
controller_input = input.review.object

isExcludedNamespace {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
}


