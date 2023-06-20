package weave.advisor.helm_release_values_from_configmaps

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
configmaps := input.parameters.configmaps

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    some i
    value_from := controller_spec.valuesFrom[i]
    value_from.kind == "ConfigMap"
    not value_from.name in configmaps
    result = {
        "issue_detected": true,
        "msg": sprintf("The HelmRelease '%s' is using an unallowed ConfigMap '%s' in valuesFrom.", [controller_input.metadata.name, value_from.name]),
        "violating_key": sprintf("spec.valuesFrom[%d].name", [i])
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
    controller_input.kind == "HelmRelease"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
