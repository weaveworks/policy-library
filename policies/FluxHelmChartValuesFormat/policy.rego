package weave.advisor.helm_chart_values_files_format

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    values_file := controller_spec.valuesFiles[_]
    not re_match(`^values(-\w+)?\.yaml$`, values_file)
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmChart '%s' must reference values files in the format 'values(-xxx)?.yaml'; found '%s'", [controller_input.metadata.name, values_file]),
        "violating_key": "spec.valuesFiles[_]"
    }
}

# Controller input
controller_input = input.review.object

# Controller spec
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
