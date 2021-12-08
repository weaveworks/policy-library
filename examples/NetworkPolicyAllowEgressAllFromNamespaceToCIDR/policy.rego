package magalix.advisor.network.allow.egress.from.namespace.to.cidr

namespace := input.parameters.namespace
cidr := input.parameters.cidr
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  some i, j
  spec_egress := np_input.spec.egress[i]
  egress_to := spec_egress.to[j]
  cidr_block := egress_to.ipBlock.cidr
  not cidr == cidr_block
  result = {
    "issue_detected": true,
    "msg": sprintf("CIDR block should be '%v'; but %v was detected", [cidr, cidr_block]),
    "violating_key": sprintf("spec.egress[%v].to[%v].ipBlock.cidr", [i,j])
  }
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}