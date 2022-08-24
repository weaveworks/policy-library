package weave.advisor.network.block_egress_traffic

import future.keywords.in

policy_type := "Egress"
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  not np_spec[lower(policy_type)] == []
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.'%v' should be '[]'; %v was detected", [lower(policy_type), np_spec[lower(policy_type)]]),
    "violating_key": "spec"
  }
}

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  policyTypes := np_spec.policyTypes
  not array_contains(policyTypes, policy_type)
  result = {
    "issue detected": true,
    "msg": sprintf("policyTypes should contain '%v'; found %v", [policy_type, np_spec.policyTypes]),
    "violating_key": "spec.policyTypes"
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

np_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}