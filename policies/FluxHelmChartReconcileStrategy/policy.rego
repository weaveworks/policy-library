package weave.advisor.helm_chart_reconcile_strategy

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    controller_spec.reconcileStrategy != "Revision"
    controller_spec.reconcileStrategy != "ChartVersion"
    result = {
        "issue detected": true,
        "msg": "The HelmChart reconcile strategy can only specify one of 'Revision' or 'ChartVersion'",
        "violating_key": "spec.reconcileStrategy"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmChart"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
