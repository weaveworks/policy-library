package weave.advisor.namespace.prohibit

namespace_name := input.parameters.namespace_name

violation[result] {
	name := namespace_input.metadata.name
  startswith(name, namespace_name)
  result = {
  	"issue_detected": true,
    "msg": sprintf("Namespaces should not start with '%v'; you have specified '%v'", [namespace_name, name]),
    "violating_key": "metadata.name"
  }
}

namespace_input = input.review.object {
  contains_kind(input.review.object.kind, {"Namespace"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
