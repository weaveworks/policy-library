package weave.advisor.rbac.prohibit_wildcards

attributes := input.parameters.attributes
exclude_role_name := input.parameters.exclude_role_name
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  not exclude_label_value == cr_input.metadata.labels[exclude_label_key]
  not exclude_role_name == cr_input.metadata.name
  some i, j
  rules := cr_input.rules[i]
  path := rules[attributes][j]
  path == "*"
  result = {
  	"issue_detected": true,
    "msg": sprintf("'%v' cannot be set to '*'; found '%v'",[attributes, path]),
    "violating_key": sprintf("rules[%v].attributes[%v]", [i,j])
  }
}

cr_input = input.review.object {
	contains(input.review.object.kind, "Role")
} 
