package weave.advisor.network.allow.ingress.to.namespace.from.cidr

namespace := input.parameters.namespace
cidr := input.parameters.cidr
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  some i, j
  spec_ingress := np_input.spec.ingress[i]
  ingress_from := spec_ingress.from[j]
  cidr_block := ingress_from.ipBlock.cidr
  not cidr == cidr_block
  result = {
    "issue_detected": true,
    "msg": sprintf("CIDR block should be '%v'; but '%v' was detected", [cidr, cidr_block]),
    "violating_key": sprintf("spec.ingress[%v].from[%v].ipBlock.cidr", [i,j]),
    "recommened_value": cidr
  }
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}