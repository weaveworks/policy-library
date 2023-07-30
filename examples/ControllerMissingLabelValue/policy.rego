package weave.advisor.labels.missing_label_value

import future.keywords.in

label := input.parameters.label
value := input.parameters.value
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  # Filter the type of entity before moving on since this shouldn't apply to all entities
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
  not value == controller_input.metadata.labels[label]
  result = {
    "issue_detected": true,
    "msg": sprintf("The key:value pair '%v:%v' was not found; detected labels: '%v", [label, value, controller_input.metadata.labels]),
    "violating_key": sprintf("metadata.labels.%v", [label]),
    "recommended_value": value
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
