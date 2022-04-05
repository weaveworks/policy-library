package weave.advisor.sa.disable_default_service_account_token_automount

automount_value = input.parameters.automount
namespace = input.parameters.namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == sa_input.metadata.labels[exclude_label_key]
  sa_input.metadata.name == "default"
  namespace == sa_input.metadata.namespace
  automount := sa_input
  not has_key(automount, "automountServiceAccountToken")
  result = {
    "issue detected": true,
    "msg": sprintf("'automountServiceAccountToken' must be set; found '%v'",[automount]),
    "violating_key": ""
  }
}

violation[result] {
  not exclude_label_value == sa_input.metadata.labels[exclude_label_key]
  sa_input.metadata.name == "default"
  namespace == sa_input.metadata.namespace
  automount := sa_input.automountServiceAccountToken
  not automount_value = automount
  result = {
    "issue detected": true,
    "msg": sprintf("automountServiceAccountToken must be set to '%v'; found '%v'",[automount_value, automount]),
    "violating_key":"automountServiceAccountToken",
    "recommended_value": automount_value
  }
}

has_key(x, k) { 
  type_name(x[k])
}

sa_input = input.review.object {
  contains_kind(input.review.object.kind, {"ServiceAccount"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}