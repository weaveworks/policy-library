package weave.advisor.labels.missing_owner_label

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  # Filter the type of entity before moving on since this shouldn't apply to all entities
  label := "owner"
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
  not controller_input.metadata.labels[label]
  result = {
    "issue detected": true,
    "msg": sprintf("you are missing a label with the key '%v'", [label]),
    "violating_key": "metadata.labels",
    "recommended_value": label
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
