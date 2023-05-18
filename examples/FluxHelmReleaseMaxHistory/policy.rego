package weave.advisor.helm_release_max_history

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
max_history := input.parameters.max_history

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    max_history_value := controller_spec.maxHistory
    max_history_value > max_history
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' maxHistory cannot exceed %d; found %d", [controller_input.metadata.name, max_history, max_history_value]),
        "violating_key": "spec.maxHistory",
        "recommended_value": max_history
    }
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
