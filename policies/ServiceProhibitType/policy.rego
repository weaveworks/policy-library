package weave.advisor.services.block_servicetype

import future.keywords.in

type := input.parameters.type
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  service_type := service_spec.type
  service_type == type
  result = {
    "issue detected": true,
    "msg": sprintf("Users not allowed to create a service type '%v'", [type]),
    "violating_key": "spec.type"
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