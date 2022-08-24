package weave.advisor.istio.approved_hosts

import future.keywords.in

hostnames := input.parameters.hostnames
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  servers := gateway_spec.servers[_]
  hosts := servers.hosts[_]
  not array_contains(hostnames, hosts)
  result = {
    "issue detected": true,
    "msg": sprintf("You have specified hosts: '%v'; detected '%v'", [hostnames, hosts]),
    "violating_key": "spec.servers.hosts"
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
gateway_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"Gateway"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
