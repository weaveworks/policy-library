package magalix.advisor.containers.block_port

container_port := input.parameters.container_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
	not exclude_namespace == controller_input.metadata.namespace
	not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
	some i, j
	container := controller_spec.containers[i]
	port := container.ports[j]
	port.containerPort == container_port
	result = {
		"issue detected": true,
		"msg": sprintf("Container should not expose port %v", [container_port]),
		"violating_key": sprintf("spec.template.spec.containers[%v].ports[%v]", [i, j]),
	}
}

controller_input = input.review.object

controller_spec = controller_input.spec.template.spec {
	contains(controller_input.kind, {"StatefulSet", "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
	controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
	controller_input.kind == "CronJob"
}

contains(kind, kinds) {
	kinds[_] = kind
}