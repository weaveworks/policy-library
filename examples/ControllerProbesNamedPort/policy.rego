package magalix.advisor.observability.named_port

healthcheck_name := "healthcheck"


### Need to be able to check if element exists inside array
# violation[result] {
#     named_port := controller_container[_].ports[_]
#     not healthcheck_name == named_port.name
#     result = {
#     	"issue_detected": true,
#         "msg": sprintf("Port name expected to be '%v', found '%v'", [healthcheck_name, named_port.name]),      
#     }
# }




violation[result] {
  named_port := controller_container[_][p][_].port
  contains(p, "Probe")
  not named_port == healthcheck_name
  result = {
    "issue_detected": true,
    "msg": sprintf("Liveness Probe port must be '%v', found '%v'", [healthcheck_name, named_port]),
    "violating_key": "spec.template.spec.containers"  
  }
}




controller_container[container] {
    container := controller_spec.containers[_]
}

# controller_container acts as an iterator to get containers from the template
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