package magalix.advisor.affinity.pod.no_schedule_toleration

toleration_key := input.parameters.toleration_key
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  tolerations := controller_spec.tolerations[i]
  key := tolerations.key
  key == toleration_key
  result = {
    "issue detected": true,
    "msg": sprintf("Toleration key must not contain '%v'; found '%v'", [toleration_key, key]),
    "violating_key": sprintf("spec.template.spec.tolerations[%v].key", [i]),
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

