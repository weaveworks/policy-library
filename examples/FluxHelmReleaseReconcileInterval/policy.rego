package weave.advisor.helm_release_reconcile_interval

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
lower_bound := input.parameters.lower_bound
upper_bound := input.parameters.upper_bound

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    reconcile_interval := controller_spec.interval
    reconcile_interval < lower_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' reconcile interval must be at least %d seconds; found %d", [controller_input.metadata.name, lower_bound, reconcile_interval]),
        "violating_key": "spec.interval"
    }
}

violation[result] {
    isExcludedNamespace == false
    reconcile_interval := controller_spec.interval
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    reconcile_interval > upper_bound
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' reconcile interval must be at most %d seconds; found %d", [controller_input.metadata.name, upper_bound, reconcile_interval]),
        "violating_key": "spec.interval"
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
