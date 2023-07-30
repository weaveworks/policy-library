package weave.advisor.mariadb.enforce_mysql_user_env_var

import future.keywords.in

env_name = "MYSQL_USER"
app_name = "mariadb"
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  contains(containers.image, app_name)
  not containers.env
  result = {
    "issue_detected": true,
    "msg": "environment variables needs to be set",
    "violating_key": sprintf("spec.template.spec.containers[%v]", [i]),  }
}

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  contains(containers.image, app_name)
  envs := containers.env
  not array_contains(envs, env_name)
  result = {
    "issue_detected": true,
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

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
