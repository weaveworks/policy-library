package magalix.advisor.rbac.prohibit_editing_configmaps

resource_name := input.parameters.resource_name
verb := input.parameters.verb
namespace := input.parameters.namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == cr_input.metadata.labels[exclude_label_key]
  namespace == cr_input.metadata.namespace
  some i
  rules := cr_input.rules[i]
  set_resource_names := rules.resourceNames
  array_contains(set_resource_names, resource_name)
  set_verbs := rules.verbs
  array_contains(set_verbs, verb)
  result = {
  	"issue detected": true,
    "msg": sprintf("ResourceName '%v' must not contain the verb '%v'; found resource '%v' with verbs '%v'",[resource_name, verb, set_resource_names, set_verbs]),
    "violating_key": sprintf("rules[%v].verbs", [i])
  }
}

array_contains(array, element) {
  array[_] = element
}

cr_input = input.review.object {
	contains(input.review.object.kind, "Role")
} 
