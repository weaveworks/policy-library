package weave.advisor.podSecurity.privileged


import future.keywords.in

privilege := input.parameters.privilege
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  container := controller_spec.containers[i]
  security_context_priv := container.securityContext.privileged
  not security_context_priv == privilege
  result = {
    "issue detected": true,
    "msg": sprintf("Container %s should set privileged to '%v'; detected '%v'", [container.name, privilege, security_context_priv]),
    "violating_key": sprintf("spec.template.spec.containers[%v].securityContext.privileged", [i]),
    "recommended_value": privilege
  }
}

is_array_contains(array,str) {
  array[_] = str
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
