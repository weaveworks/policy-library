package weave.advisor.images.image_name_enforce

import future.keywords.in

restricted_image_names := input.parameters.restricted_image_names
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers = controller_spec.containers[i]
  splittedUrl = split(containers.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  not contains(image, ":")
  array_contains(restricted_image_names, image)
  result = {
    "issue detected": true,
    "msg": sprintf("These images should be blocked: '%v'; found '%v'", [restricted_image_names, image]),
    "image": image,
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])  
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers = controller_spec.containers[i]
  splittedUrl = split(containers.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  count(split(image, ":")) == 2
  [image_name, tag] = split(image, ":")
  array_contains(restricted_image_names, image_name)
  result = {
    "issue detected": true,
    "msg": sprintf("These images should be blocked: '%v'; found '%v'", [restricted_image_names, image]),
    "image": image_name,
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])  
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers = controller_spec.containers[i]
  splittedUrl = split(containers.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  count(split(image, ":")) == 3
  [image_name, tag] = split(image, ":")
  array_contains(restricted_image_names, image_name)
  result = {
    "issue detected": true,
    "msg": sprintf("These images should be blocked: '%v'; found '%v'", [restricted_image_names, image]),
    "image": image_name,
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])  
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

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
