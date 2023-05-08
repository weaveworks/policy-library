package weave.advisor.helm_chart_source_refrence

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    controller_spec.sourceRef.kind != "HelmRepository"
    controller_spec.sourceRef.kind != "GitRepository"
    controller_spec.sourceRef.kind != "Bucket"
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The 'sourceRef.kind' field in the 'spec.chart' section of a HelmChart object can only be one of 'HelmRepository' or 'GitRepository', but found '%s'", [controller_spec.sourceRef.kind]),
        "violating_key": "spec.chart.sourceRef.kind"
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
