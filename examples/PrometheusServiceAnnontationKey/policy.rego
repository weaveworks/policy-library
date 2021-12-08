package magalix.advisor.annotations.prometheus_service

annotation := input.parameters.prometheus_service_annotation
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not service_input.metadata.annotations[annotation]
  not exclude_namespace == service_input.metadata.namespace
  not exclude_label_value == service_input.metadata.labels[exclude_label_key]
  result = {
    "issue detected": true,
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