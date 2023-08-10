package weave.advisor.istio.namespace_label

namespaces := input.parameters.namespaces

violation[result] {
  namespace_name := namespace_input.metadata.name
  array_contains(namespaces, namespace_name)
  not namespace_input.metadata.labels["istio-injection"]
  result = {
    "issue_detected": true,
    "msg": sprintf("The namespace '%v' is missing the label 'istio-injection'", [namespaces[_]]),
    "violating_key": "metadata.name"
  }
}

violation[result] {
  namespace_name := namespace_input.metadata.name
  array_contains(namespaces, namespace_name)
  label := namespace_input.metadata.labels["istio-injection"]
  not label == "enabled"
  result = {
    "issue_detected": true,
    "msg": sprintf("The 'istio-injection' lable should be 'enabled'; found '%v'", [label]),
    "violating_key": "metadata.name.labels"
  }
}

array_contains(array, element) {
  array[_] = element
}

# controller_container acts as an iterator to get containers from the template
namespace_input = input.review.object {
  contains_kind(input.review.object.kind, {"Namespace"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}

