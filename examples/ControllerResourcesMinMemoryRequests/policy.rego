package weave.advisor.controller.min_memory_requests

import future.keywords.in

min_size := input.parameters.size
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  container := controller_spec.containers[i]
  mem_requests := container.resources.requests.memory
  mem_requests_value := units.parse_bytes(mem_requests)
  min_size_value := units.parse_bytes(min_size)
  mem_requests_value < min_size_value
  result = {
    "issue detected": true,
    "msg": sprintf("Memory requests must be a minimum of '%v'; found '%v'", [min_size, mem_requests]),
    "violating_key": sprintf("spec.template.spec.containers[%v].resources.requests.memory", [i])
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