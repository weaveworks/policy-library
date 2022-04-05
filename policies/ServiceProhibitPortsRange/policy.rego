package weave.advisor.services.block_ports

target_port := input.parameters.target_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  spec_port := service_spec.ports[i]
  service_port := spec_port.targetPort
  not service_port > target_port
  result = {
    "issue detected": true,
    "msg": sprintf("targetPort is not greater than '%v'; found %v", [target_port, service_port]),
    "violating_key": sprintf("spec.ports[%v].targetPort", [i])
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