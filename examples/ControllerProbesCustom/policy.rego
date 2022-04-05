package weave.advisor.observability.custom_probes

probe_type := input.parameters.probe_type
command := input.parameters.command
path := input.parameters.path
port := input.parameters.port 
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

# Use this if you are using exec
violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  probe_command := containers[probe_type].exec.command
  not (probe_command == command)
  result = {
	"issue_detected": true,
    "msg": sprintf("Expecting commands '%v'; found '%v'", [command, probe_command]),
    "violating_key": sprintf("spec.template.spec.containers[%v][probe_type].exec.command", [i]),
    "recommended_value": command
	}
}

# Use this if you are using httpGet
violation[result] {
  not exclude_namespace == controller_input.metadata.namespace
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  some i
  containers := controller_spec.containers[i]
  probe_path := containers[probe_type].httpGet.path
  not path == probe_path
  result = {
	"issue_detected": true,
    "msg": sprintf("Expecting httpGet path '%v'; found '%v'", [path, probe_path]),
    "violating_key": sprintf("spec.template.spec.containers[%v][probe_type].httpGet.path", [i]),
     "recommended_value": path
	}
}

# Use this if you are using tcpSocket without a named port
violation[result] {
  some i
  containers := controller_spec.containers[i]
  probe_port := containers[probe_type].tcpSocket.port
  not port ==  probe_port
  result = {
	"issue_detected": true,
    "msg": sprintf("Expecting port '%v'; found '%v'", [port, probe_port]),   
    "violating_key": sprintf("spec.template.spec.containers[%v][probe_type].tcpSocket.port", [i]),
     "recommended_value": port
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