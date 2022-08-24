package weave.advisor.podSecurity.runningAsUser

import future.keywords.in

uid := input.parameters.uid
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

# Check for missing securityContext.runAsUser (missing in both, pod and container)
violation[result] {
	not controller_input.metadata.namespace in exclude_namespaces
	not exclude_label_value == controller_input.metadata.labels[exclude_label_key]

	controller_spec.securityContext
	not controller_spec.securityContext.runAsUser

	some i
	containers := controller_spec.containers[i]
	containers.securityContext
	not containers.securityContext.runAsUser

	result = {
		"issue detected": true,
		"msg": sprintf("Missing spec.template.spec.containers[%v].securityContext.runAsUser and spec.template.spec.securityContext.runAsUser is not defined as well.", [i]),
		"violating_key": sprintf("spec.template.spec.containers[%v].securityContext", [i]),
	}
}

# Container security context
# Check if containers.securityContext.runAsUser exists and <= uid
violation[result] {
	not controller_input.metadata.namespace in exclude_namespaces
	not exclude_label_value == controller_input.metadata.labels[exclude_label_key]

	some i
	containers := controller_spec.containers[i]
	containers.securityContext
	containers.securityContext.runAsUser
	containers.securityContext.runAsUser <= uid
	
	result = {
		"issue detected": true,
		"msg": sprintf("Container is potentially running as root. Please check spec.template.spec.containers[%v].securityContext.runAsUser to see if the UID is correct.", [i]),
		"violating_key": sprintf("spec.template.spec.containers[%v].securityContext", [i]),
	}
}

# Pod security context
# Check if spec.securityContext.runAsUser exist and <= uid
violation[result] {
	not controller_input.metadata.namespace in exclude_namespaces
	not exclude_label_value == controller_input.metadata.labels[exclude_label_key]

	controller_spec.securityContext
	controller_spec.securityContext.runAsUser
	controller_spec.securityContext.runAsUser <= uid

	result = {
		"issue detected": true,
		"msg": "A container is potentially running as root. Please check spec.template.spec.securityContext.runAsUser to see if the UID is correct.",
		"violating_key": "spec.template.spec.securityContext",
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