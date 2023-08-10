package weave.advisor.annotations.prometheus_service

import future.keywords.in

annotation := input.parameters.prometheus_service_annotation
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == service_input.metadata.labels[exclude_label_key]
  not service_input.metadata.annotations[annotation]
  result = {
    "issue_detected": true,
    "msg": sprintf("Annotation must contain '%v'; found '%v'", [annotation, service_input.metadata.annotations]),
    "violating_key": "metadata.annotations"
  }
}

service_input = input.review.object {
	contains_kind(input.review.object.kind, {"Service"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	service_input.metadata.namespace
	service_input.metadata.namespace in exclude_namespaces
} else = false
