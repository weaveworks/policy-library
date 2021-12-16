package magalix.advisor.k8s.prohibit_kind

kind := input.parameters.kind

violation[result] {
	lower_kind := lower(kind)
	specified_kind := input.review.object.kind
	lower_specified_kind := lower(specified_kind)
  lower_kind == lower_specified_kind
  result = {
    "issue detected": true,
    "msg": sprintf("Unapproved kind '%v'; found '%v'", [kind, specified_kind]),
    "violating_key": "kind"
  }
}
