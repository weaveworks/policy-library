package weave.advisor.network.allow.egress.from_namespace_to_namespace

src_namespace := input.parameters.src_namespace
dst_namespace := input.parameters.dst_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  src_namespace == np_input.metadata.namespace
  some i, j
  egress := np_input.spec.egress[i]
  to := egress.to[j]
  not dst_namespace == to.namespaceSelector.matchLabels["kubernetes.io/metadata.name"]
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.egress[%v].to[%v].namespaceSelector does not match the namespace %v;", [i, j, dst_namespace]),
    "violating_key": sprintf("spec.egress[%v].to[%v].namespaceSelector", [i, j])
  }
}

violation[result] {
  not exclude_label_value == np_input.metadata.labels[exclude_label_key]
  src_namespace == np_input.metadata.namespace
  np_input.spec.egress == [{}]
  result = {
    "issue_detected": true,
    "msg": sprintf("spec.egress allows all egress. It should have a specific 'to' role for the namespace %v;", [dst_namespace]),
    "violating_key": "spec.egress"
  }
}

np_input = input.review.object {
  contains_kind(input.review.object.kind, {"NetworkPolicy"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}