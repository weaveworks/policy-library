package magalix.advisor.pods.not_namespace

custom_namespace := input.parameters.custom_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  namespace := controller_input.metadata.namespace
  namespace == custom_namespace
  result = {
    "issue detected": true,
    "msg": sprintf("Workloads must not be running in the namespace '%v'; found '%v'", [custom_namespace, namespace]),
    "violating_key": "metadata.namespace"
  }
}

controller_input = input.review.object {
	contains_kind(input.review.object.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job", "Pod", "CronJob"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}