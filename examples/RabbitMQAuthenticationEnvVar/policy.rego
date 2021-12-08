package magalix.advisor.rabbitmq.enforce_env_vars_authentication

env_name = input.parameters.envvar_name
app_name = input.parameters.app_name
exclude_namespace = input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  contains(containers.image, app_name)
  not containers.env
  result = {
    "issue detected": true,
    "msg": "environment variables needs to be set",
    "violating_key": sprintf("spec.template.spec.containers[%v]", [i])
  }
}

violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  contains(containers.image, app_name)
  envs := containers.env
  not array_contains(envs, env_name)
  result = {
    "issue detected": true,
    "msg": sprintf("'%v' is missing'; detected '%v'", [env_name, envs]),
    "violating_key": sprintf("spec.template.spec.containers[%v].env.name", [i])
  }
}


array_contains(array, element) {
  array[_].name = element
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