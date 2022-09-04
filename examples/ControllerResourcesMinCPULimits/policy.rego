package weave.advisor.controller.min_cpu_limits

import future.keywords.in

min_size := input.parameters.size
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  container := controller_spec.containers[i]
  cpu_limits := container.resources.limits.cpu
  cpu_limits_value := units.parse_bytes(cpu_limits)
  min_size_value := units.parse_bytes(min_size)
  cpu_limits_value < min_size_value
  result = {
    "issue detected": true,
    "msg": sprintf("CPU limits must be a minimum of '%v'; found '%v'", [min_size, cpu_limits]),
    "violating_key": "spec.template.spec.containers.resources.limits.cpu"  
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

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
