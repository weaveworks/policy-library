package weave.advisor.k8s.prohibit_naked_pods

violation[result] {
  kind := "Pod"
	lower_kind := lower(kind)
	specified_kind := input.review.object.kind
	lower_specified_kind := lower(specified_kind)
  lower_kind == lower_specified_kind
  result = {
    "issue detected": true,
    "msg": sprintf("Naked Pods are prohibited",[]),
    "violating_key": "kind"
  }
}
