package magalix.advisor.network.block.ingress.to.namespace.from.cidr

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
  not array_contains(ingress_from.ipBlock.except, cidr)
  result = {
    "issue_detected": true,
    "msg": sprintf("CIDR block should contain '%v'; but %v was detected", [cidr, ingress_from.ipBlock.except]),
    "violating_key": sprintf("spec.egress[%v].from[%v].ipBlock.cidr.except", [i, j]),
    "recommended_value": cidr
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