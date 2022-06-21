package weave.advisor.podSecurity.privilegeEscalation

exclude_namespace := input.parameters.exclude_namespace
allow_privilege_escalation := input.parameters.allow_privilege_escalation
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  some i
  isExcludedNamespace == false
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  containers := controller_spec.containers[i]
  allow_priv := containers.securityContext.allowPrivilegeEscalation
  not allow_priv == allow_privilege_escalation
  result = {
    "issue detected": true,
    "msg": sprintf("Container %s privilegeEscalation should be set to '%v'; detected '%v'", [containers[i].name, allow_privilege_escalation, allow_priv]),
    "violating_key": sprintf("spec.template.spec.containers[%v].securityContext.allowPrivilegeEscalation", [i]),
    "recommended_value": allow_privilege_escalation
  }
}

isExcludedNamespace  = true {
  input.review.object.metadata.namespace == exclude_namespace
}else = false {true}

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
