package magalix.advisor.pods.block_ports

target_port := input.parameters.target_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i,j
  containers := controller_spec.containers[i]
  container_ports := containers.ports[j]
  port := container_ports.containerPort
  not port >= target_port
  result = {
    "issue detected": true,
    "msg": sprintf("containerPort is not greater than '%v'; found %v", [target_port, port]),
    "violating_key": sprintf("spec.template.spec.containers[%v].ports[%v].containerPort", [i,j]) 
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