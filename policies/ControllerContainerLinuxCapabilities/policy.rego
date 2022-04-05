package weave.advisor.podSecurity.capabilities

exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  isViolatingTheCapabilities
  result = {
    "issue detected": true,
    "msg": "Running unapproved capabilities",
    "violating_key": "spec.template.spec.containers.securityContext.capabilities"  
  }
}

isExcludedNamespace  = true {
	input.review.object.metadata.namespace == exclude_namespace
}else = false {true}


is_array_contains(array,str) {
  array[_] = str
}

dangerousCap := {"SYS_ADMIN","NEW_RAW","NET_ADMIN","ALL"}

isViolatingTheCapabilities = true {
	container := controller_spec.containers[_]
    cap := container.securityContext.capabilities.add[_]
    is_array_contains(dangerousCap,cap)

}else = true{
    cap := controller_spec.securityContext.capabilities.add[_]
    is_array_contains(dangerousCap,cap)
    container := controller_spec.containers[_]
    not  container.securityContext.capabilities


}else = true{
    cap := controller_spec.securityContext.capabilities.add[_]
    is_array_contains(dangerousCap,cap)
    container := controller_spec.containers[_]
    not  count(container.securityContext.capabilities.add) >=0
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
