package weave.advisor.network.allow.ingress.to.namespace

namespace := input.parameters.namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  namespace == np_input.metadata.namespace
  not np_input.spec.ingress == [{}]
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.ingress should be '[]'; %v was detected", [np_input.spec.ingress]),
    "violating_key": "spec.ingress"
  }
}


np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}