package magalix.advisor.labels.missing_kubernetes_app_instance_label

exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  label := "app.kubernetes.io/instance"
  # Filter the type of entity before moving on since this shouldn't apply to all entities
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
  not controller_input.metadata.labels[label]
  result = {
    "issue detected": true,
    "msg": sprintf("Missing '%v' label", [label]),
    "violating_key": "metadata.labels",
    "recommended_value": label
  }
}

# Controller input
controller_input = input.review.object

contains_kind(kind, kinds) {
  kinds[_] = kind
}