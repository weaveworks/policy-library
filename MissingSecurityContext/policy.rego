package magalix.advisor.podSecurity.missing_security_context

violation[result] {
	not controller_spec.securityContext	# Pod securityContext missing
	some i
	containers := controller_spec.containers[i]
	not containers.securityContext	# Container securityContext missing
	result = {
		"issue detected": true,
		"msg": sprintf("Container missing spec.template.spec.containers[%v].securityContext while Pod spec.template.spec.securityContext is not defined as well.", [i]),
		"violating_key": "spec.template.spec.containers[%v]",
	}
}

controller_input = input.review.object

controller_spec = controller_input.spec.template.spec {
	contains(controller_input.kind, {"StatefulSet", "DaemonSet", "Deployment", "Job", "ReplicaSet"})
} else = controller_input.spec {
	controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
	controller_input.kind == "CronJob"
}

contains(kind, kinds) {
	kinds[_] = kind
}