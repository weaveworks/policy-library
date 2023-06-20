package weave.advisor.images.approved_registry

import future.keywords.in

my_registries := input.parameters.registries
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  container_controller := controller_spec.containers[i]
  image_path := container_controller.image
  registry := get_registry(image_path)
  not array_contains(my_registries, registry)
  result = {
    "issue_detected": true,
    "msg": sprintf("regsitry must be from '%v'; found '%v'", [my_registries, registry]),
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])
  }
}

get_registry(str) = registry {
  contains(str, "/")
  path := split(str, "/")
  registry := path[0]
}

get_registry(str) = registry {
  not contains(str, "/")
  registry := ""
}

array_contains(array, element) {
  array[_] = element
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

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
