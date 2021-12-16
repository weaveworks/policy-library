package magalix.advisor.rbac.generic_prohibit_resource_verb

resource := input.parameters.resource
verb := input.parameters.verb
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == cr_input.metadata.labels[exclude_label_key]
  some i
  rules := cr_input.rules[i]
  set_resources := rules.resources
  array_contains(set_resources, resource)
  set_verbs := rules.verbs
  array_contains(set_verbs, verb)
  result = {
  	"issue detected": true,
    "msg": sprintf("Resource '%v' must not contain the verb '%v'; found resource '%v' with verbs '%v'",[resource, verb, set_resources, set_verbs]),
    "violating_key": sprintf("rules[%v].verbs", [i])
  }
}

array_contains(array, element) {
  array[_] = element
}

cr_input = input.review.object {
	contains(input.review.object.kind, "Role")
} 
