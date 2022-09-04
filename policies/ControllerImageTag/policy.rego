package weave.advisor.images.image_tag_enforce

import future.keywords.in

image_tag := input.parameters.image_tag
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i,container in controller_spec.containers
  splittedUrl = split(container.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  not contains(image, ":")
  result = {
    "issue detected": true,
    "msg": sprintf("Container %s image is not tagged", container.name),
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i,container in controller_spec.containers
  splittedUrl = split(container.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  count(split(image, ":")) == 2
  [image_name, tag] = split(image, ":")
  tag == image_tag
  result = {
    "issue detected": true,
    "msg": sprintf("Container %s image contains unapproved tag '%v'", [container.name, image_tag]),
    "image": image,
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])
  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i,container in controller_spec.containers
  splittedUrl = split(container.image, "/")
  image = splittedUrl[count(splittedUrl)-1]
  count(split(image, ":")) == 3
  [image_name, port, tag] = split(image, ":")
  tag == image_tag
  result = {
    "issue detected": true,
    "msg": sprintf("Container %s image contains unapproved tag:'%v'", [container.name, image_tag]),
    "image": image,
    "violating_key": sprintf("spec.template.spec.containers[%v].image", [i])
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

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
