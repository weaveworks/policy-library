package magalix.advisor.podSecurity.seccomp_runtime_default

seccomp_annotation := input.parameters.seccomp_annotation
seccomp_type := input.parameters.seccomp_type
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  annotation := input.review.object.metadata.annotations["seccomp.security.alpha.kubernetes.io/pod"]
  not annotation == seccomp_annotation
  result = {
    "issue detected": true,
    "msg": sprintf("The value of the annotation must be '%v'; found '%v'",[seccomp_annotation, annotation]),
    "violating_key": "spec.metadata.annotations"  
  }
}

# Pods
violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  type := controller_spec.securityContext.seccompProfile.type
  not type == seccomp_type
  result = {
    "issue detected": true,
    "msg": sprintf("The secompProfile type must be '%v'; found '%v'",[seccomp_type, type]),
    "violating_key": "spec.template.spec.securityContext.seccompProfile.type"  
  }
}

# Non Pods - "StatefulSet" , "DaemonSet", "Deployment", "Job"
violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  type := controller_spec.template.spec.securityContext.seccompProfile.type
  not type == seccomp_type
  result = {
    "issue detected": true,
    "msg": sprintf("The secompProfile type must be '%v'; found '%v'",[seccomp_type, type]),
    "violating_key": "spec.template.spec.securityContext.seccompProfile.type"  
  }
}

# CronJobs
violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  type := controller_input.spec.jobTemplate.spec.template.spec.securityContext.seccompProfile.type
  not type == seccomp_type
  result = {
    "issue detected": true,
    "msg": sprintf("The secompProfile type must be '%v'; found '%v'",[seccomp_type, type]),
    "violating_key": "spec.jobTemplate.spec.template.spec.securityContext.seccompProfile.type"  
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
