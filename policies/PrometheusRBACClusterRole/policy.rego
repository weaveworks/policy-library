package weave.advisor.rbac.prometheus_server_clusterrole

verb := input.parameters.prometheus_verb
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == cr_input.metadata.labels[exclude_label_key]
  contains(cr_input.metadata.name, "prometheus")
  some i, j
  rules := cr_input.rules[i]
  verbs := rules.verbs[j]
  contains(verbs, verb)
  result = {
    "issue detected": true,
    "msg": sprintf("Found unapproved verb '%v'", [verb]),
    "violating_key": sprintf("rules[%v].verbs[%v]",[i,j])
  }
}

cr_input = input.review.object {
	contains_kind(input.review.object.kind, {"ClusterRole"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
