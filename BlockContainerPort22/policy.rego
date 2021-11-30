package magalix.advisor.containers.block_port

import data.exclusions
import data.utils

container_port := input.parameters.container_port
exclude_namespace := input.parameters.exclude_namespace
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
	not exclusions.excludeNamespace(exclude_namespace)
	not exclusions.excludeLabel(exclude_label_key, exclude_label_value)
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

controller_spec = utils.controller_input.spec.template.spec {
	utils.contains(utils.controller_input.kind, {"StatefulSet", "DaemonSet", "Deployment", "Job"})
} else = utils.controller_input.spec {
	utils.controller_input.kind == "Pod"
} else = utils.controller_input.spec.jobTemplate.spec.template.spec {
	utils.controller_input.kind == "CronJob"
}
