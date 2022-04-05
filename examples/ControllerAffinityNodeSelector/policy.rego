package weave.advisor.affinity.node_selector

key := input.parameters.key
value := input.parameters.value
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  not controller_spec.nodeSelector[key]
  result = {
    "issue detected": true,
    "msg": sprintf("Looking for key '%v'; found '%v'", [key, controller_spec.nodeSelector]),
    "violating_key": "spec.template.spec.nodeSelector",
    "recommended_value": value  
  }
}

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  selector_value := controller_spec.nodeSelector[key]
  not selector_value == value
  result = {
    "issue detected": true,
    "msg": sprintf("Looking for key value pair '%v:%v'; found '%v'", [key, value, controller_spec.nodeSelector]),
    "recommended_value": value,
    "violating_key": "spec.template.spec.nodeSelector[key]"
  }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec.template.spec {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}