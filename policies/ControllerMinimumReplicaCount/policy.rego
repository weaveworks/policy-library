package weave.advisor.pods.replica_count

import future.keywords.in

replica_count := input.parameters.replica_count
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not controller_input.metadata.namespace in exclude_namespaces
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  not controller_input.spec.replicas >= replica_count
  result = {
    "issue detected": true,
    "msg": sprintf("Replica count must be greater than or equal to '%v'; found '%v'.", [replica_count, controller_input.spec.replicas]),
    "violating_key": "spec.replicas",
    "recommended_value": replica_count
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
