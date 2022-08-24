package weave.advisor.prometheus.annotation_value

import future.keywords.in

annotation_key := input.parameters.prometheus_annotation_key
annotation_value := input.parameters.prometheus_annotation_value
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  annotation := controller_input.spec.template.metadata.annotations[annotation_key]
  value := annotation
  not annotation_value == value
  result = {
    "issue detected": true,
    "msg": sprintf("Annotation '%v' expected value '%v'; found '%v'",[annotation_key, annotation_value, value ]),
    "violating_key": sprintf("spec.template.metadata.annotation[%v]", [annotation_key]),
    "recommended_value": annotation_value
  }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec.template.spec {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}