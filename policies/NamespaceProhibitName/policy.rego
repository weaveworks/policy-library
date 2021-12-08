package magalix.advisor.namespace.prevent_kube_dash

namespace_name := input.parameters.namespace_name

violation[result] {
	name := namespace_input.metadata.name
  startswith(name, namespace_name)
  result = {
  	"issue detected": true,
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
