package weave.advisor.labels.missing_matchlabel

import future.keywords.in

label := input.parameters.label
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  selector_label := controller_spec.selector.matchLabels
  not has_key(selector_label, label)
  result = {
    "issue detected": true,
    "msg": sprintf("Expecting key '%v'; found '%v'", [label, selector_label]),
    "violating_key": "spec.selector.matchLabels"  
  }
}

has_key(x, k) { 
  type_name(x[k])
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
