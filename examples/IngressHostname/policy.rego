package weave.advisor.ingress.approved_hostnames

import future.keywords.in

hostnames := input.parameters.hostnames
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  rules := ingress_spec.rules[i]
  hosts := rules.host
  not array_contains(hostnames, hosts)
  result = {
    "issue detected": true,
    "msg": sprintf("Approved domain names should be '%v'; detected '%v'", [hostnames, hosts]),
    "violating_key": sprintf("spec.rules[%v].host", [i])
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

ingress_spec = input.review.object.spec {
  contains_kind(input.review.object.kind, {"Ingress"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

