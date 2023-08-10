package weave.advisor.labels.missing_spec_template_label

import future.keywords.in

label := input.parameters.label
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
  not controller_input.spec.template.metadata.labels[label]
  result = {
    "issue_detected": true,
    "msg": sprintf("you are missing a template spec label with the key '%v'", [label]),
    "violating_key": "spec.template.metadata.labels"  
  }
}

# Controller input
controller_input = input.review.object

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
