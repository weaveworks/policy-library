package weave.advisor.ingress.ingress_class

import future.keywords.in

annotation  := input.parameters.annotation
class := input.parameters.class
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  ingress_annotation := controller_input.metadata.annotations
  not has_key(ingress_annotation, annotation)
  result = {
    "issue detected": true,
    "msg": sprintf("Ingress is missing the annoation '%v'", [annotation]),
    "violating_key": "metadata.annotations"
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  ingress_class:= controller_input.metadata.annotations[annotation]
  not ingress_class == class
  result = {
    "issue detected": true,
    "msg": sprintf("Ingress class should '%v'; found '%v' ", [class, ingress_class]),
    "violating_key": "metadata.annotations",
    "recommended_value": class
    
  }
}

has_key(x, k) { 
  type_name(x[k])
}

controller_input = input.review.object {
	contains_kind(input.review.object.kind, {"Ingress"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
