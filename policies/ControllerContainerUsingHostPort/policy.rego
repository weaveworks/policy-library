package weave.advisor.podSecurity.deny_hostport

host_port := input.parameters.host_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i, j
  container := controller_spec.containers[i]
  ports := container.ports[j]
  has_key(ports, host_port)
  result = {
    "issue detected": true,
    "msg": sprintf("'%v' should not be used unless absolutely necessary; found %v", [host_port, ports]),
    "violating_key": sprintf("spec.template.spec.containers[%v].ports[%v]", [i,j])  
  }
}

has_key(x, k) { 
  type_name(x[k])
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