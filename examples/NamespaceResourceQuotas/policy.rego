package magalix.advisor.namespace.resource_quotas

resource_type := input.parameters.resource_type
resource_setting := input.parameters.resource_setting

violation[result] {
  not rq_spec.hard[resource_setting][resource_type]
  result = {
  	"issue detected": true,
    "msg": sprintf("You are missing '%v' '%v'", [resource_type, resource_setting]),
    "violating_key": "spec.hard"
  }
}

rq_spec = input.review.object.spec{
  contains_kind(input.review.object.kind, {"ResourceQuota"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
