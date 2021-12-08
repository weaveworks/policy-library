package magalix.advisor.ingress.ingress_class

annotation  := input.parameters.annotation
class := input.parameters.class
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == ingress_input.metadata.namespace
  not exclude_label_value == ingress_input.metadata.labels[exclude_label_key]
  ingress_annotation := ingress_input.metadata.annotations
  not has_key(ingress_annotation, annotation)
  result = {
    "issue detected": true,
    "msg": sprintf("Ingress is missing the annoation '%v'", [annotation]),
    "violating_key": "metadata.annotations"
  }
}

violation[result] {
  not exclude_namespace == ingress_input.metadata.namespace
  not exclude_label_value == ingress_input.metadata.labels[exclude_label_key]
  ingress_class:= ingress_input.metadata.annotations[annotation]
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


ingress_input = input.review.object {
	contains_kind(input.review.object.kind, {"Ingress"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}