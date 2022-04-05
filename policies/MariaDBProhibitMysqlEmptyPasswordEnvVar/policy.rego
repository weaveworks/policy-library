package weave.advisor.mariadb.prohibit_mysql_empty_password_env_var

env_name = "MYSQL_ALLOW_EMPTY_PASSWORD"
app_name = "mariadb"
exclude_namespace = input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value


violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i, j
  containers := controller_spec.containers[i]
  contains(containers.image, app_name)
  envs := containers.env[j]
  envs.name == env_name
  result = {
    "issue detected": true,
    "msg": sprintf("'%v' should not be set, but has been detected here '%v'", [env_name, envs]),
    "violating_key": sprintf("spec.template.spec.containers[%v].securityContext.allowPrivilegeEscalation", [i]),
  }
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