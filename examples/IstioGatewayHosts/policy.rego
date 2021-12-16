package magalix.advisor.istio.approved_hosts

hostnames := input.parameters.hostnames
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  not exclude_namespace == input.review.object.metadata.namespace
  not exclude_label_value == input.review.object.metadata.labels[exclude_label_key]
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

# controller_container acts as an iterator to get containers from the template
gateway_spec = input.review.object.spec {
  contains_kind(input.review.object.kind, {"Gateway"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
