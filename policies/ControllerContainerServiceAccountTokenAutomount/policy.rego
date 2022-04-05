package weave.advisor.pods.service_account_token_automount

automount_token := input.parameters.automount_token
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  automount := controller_spec
  not has_key(automount, "automountServiceAccountToken")
  result = {
    "issue detected": true,
    "msg": sprintf("'automountServiceAccountToken' must be set; found '%v'",[automount]),
    "violating_key": "spec.template.spec"
  }
}

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  automount := controller_spec.automountServiceAccountToken
  not automount == automount_token
  result = {
    "issue detected": true,
    "msg": sprintf("automountServiceAccountToken must be '%v'; found '%v'",[automount_token, automount]),
    "violating_key": "spec.template.spec.automountServiceAccountToken",
    "recommended_value": automount_token
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
