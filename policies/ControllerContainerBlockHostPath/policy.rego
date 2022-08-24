package weave.advisor.pods.hostpath

import future.keywords.in

hostpath_key := input.parameters.hostpath_key
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  volumes := controller_spec.volumes[i]
  has_key(volumes, hostpath_key)
  result = {
    "issue detected": true,
    "msg": sprintf("Containers should not be using hostPath; found %v", [volumes]),
    "violating_key": sprintf("spec.template.spec.volumes[%v]", [i])
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