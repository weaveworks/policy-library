package magalix.advisor.network.allow.ingress.from_namespace_to_namespace

src_namespace := input.parameters.src_namespace
dst_namespace := input.parameters.dst_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  dst_namespace == np_input.metadata.namespace
  some i, j
  ingress := np_input.spec.ingress[i]
  from := ingress.from[j]
  not src_namespace == from.namespaceSelector.matchLabels["kubernetes.io/metadata.name"]
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.ingress[%v].from[%v].namespaceSelector does not match the namespace %v;", [i, j, src_namespace]),
    "violating_key": sprintf("spec.ingress[%v].from[%v].namespaceSelector", [i, j])
  }
}

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  dst_namespace == np_input.metadata.namespace
  np_input.spec.ingress == [{}]
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.ingress allows all ingress. It should have a specific 'from' role for the namespace %v;", [src_namespace]),
    "violating_key": "spec.ingress"
  }
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}