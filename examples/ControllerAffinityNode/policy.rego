package weave.advisor.affinity.nodes

import future.keywords.in

keys := input.parameters.keys
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  walk(controller_spec, [path, value])
  key := path[count(path) - 1]
  key == "key"
  not array_contains(keys, value)
  result = {
    "issue_detected": true,
    "msg": sprintf("Expecting key '%v'; detected '%v'", [keys, value]),
    "violating_key": "spec.template.spec.affinity.nodeAffinity"
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

controller_spec = controller_input.spec.template.spec.affinity.nodeAffinity {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec.affinity.nodeAffinity {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
