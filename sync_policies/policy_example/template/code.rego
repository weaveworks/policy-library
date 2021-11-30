package magalix.template.probes

violation[result] {
  container := controller_container[_]
  not container[input.parameters.probe]
  result = {
		"issue": true,
	}
}

controller_container[container] {
    container := controller_spec.containers[_]
}


controller_spec = input.review.object.spec.template.spec {
	contains_kind(input.review.object.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = input.review.object.spec {
	input.review.object.kind == "Pod"
} else = input.review.object.spec.jobTemplate.spec.template.spec {
	input.review.object.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}