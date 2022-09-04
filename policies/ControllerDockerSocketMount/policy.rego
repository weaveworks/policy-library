package weave.advisor.podSecurity.deny_docker_socket_mount

import future.keywords.in

docker_socket_name := input.parameters.docker_socket
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i, j
  sock := controller_spec.containers[i]
  vmounts := sock.volumeMounts[j]
  sock_path := vmounts.hostPath.path 
  contains(sock_path, docker_socket_name) 
  result = {
    "issue detected": true,
    "msg": sprintf("'%v' is being mounted. The hostPath we found was '%v'",[docker_socket_name, sock_path]),
    "violating_key": sprintf("spec.template.spec.containers[%v].volumeMonuts[%v].hostPath.path", [i,j])  
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
