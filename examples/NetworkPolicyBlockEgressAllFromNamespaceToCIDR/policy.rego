package weave.advisor.network.block.egress.from.namespace.to.cidr

namespace := input.parameters.namespace
blocked_cidr := input.parameters.blocked_cidr
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  some i, j
  spec_egress := np_input.spec.egress[i]
  egress_to := spec_egress.to[j]
  not array_contains(egress_to.ipBlock.except, blocked_cidr)
  result = {
    "issue_detected": true,
    "msg": sprintf("CIDR block should contain '%v'; but %v was detected", [blocked_cidr, egress_to.ipBlock.except]),
    "violating_key": sprintf("spec.egress[%v].to[%v].ipBlock.cidr.except", [i,j]),
  }
}

array_contains(array, element) {
  array[_] = element
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}