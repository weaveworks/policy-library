package weave.advisor.podSecurity.block_sysctls

exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
	not exclude_namespace == controller_input.metadata.namespace
	not exclude_label_value == controller_input.metadata.labels[exclude_label_key]

    controller_spec.securityContext.sysctls
	
	result = {
		"issue detected": true,
		"msg": "Adding sysctls could lead to unauthorized escalated privileges to the underlying node",
		"violating_key": "spec.template.spec.securityContext.sysctls"
	}
}

###### Functions
isArrayContains(array, str) {
	array[_] = str
}

# Initial Setup
controller_input = input.review.object

controller_spec = controller_input.spec.template.spec {
	isArrayContains({"StatefulSet", "DaemonSet", "Deployment", "Job", "ReplicaSet"}, controller_input.kind)
} else = controller_input.spec {
	controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
	controller_input.kind == "CronJob"
}
