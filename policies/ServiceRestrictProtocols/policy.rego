package weave.advisor.services.block_protocols

import future.keywords.in

service_protocol := input.parameters.protocols
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  ports := service_spec.ports[i]
  existing_protocol := ports.protocol
  not service_protocol == existing_protocol
  result = {
    "issue detected": true,
    "msg": sprintf("Protocol should be '%v'; found '%v'", [service_protocol, existing_protocol]),
    "violating_key": sprintf("spec.ports[%v].protocol", [i]),
    "recommended_value": service_protocol
  }
}

# Controller input
controller_input = input.review.object

service_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"Service"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}