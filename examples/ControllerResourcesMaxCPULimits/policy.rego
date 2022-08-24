package weave.advisor.controller.max_cpu_limits

import future.keywords.in

max_size := input.parameters.size
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  container := controller_spec.containers[i]
  cpu_limits := container.resources.limits.cpu
  cpu_limits_value := units.parse_bytes(cpu_limits)
  max_size_value := units.parse_bytes(max_size)
  cpu_limits_value > max_size_value
  result = {
    "issue detected": true,
    "msg": sprintf("CPU limits must be a maximum of '%v'; found '%v'", [max_size, cpu_limits]),
    "violating_key": sprintf("spec.template.spec.containers[%v].resources.limits.cpu", [i]),
    "recommended_value": max_size
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