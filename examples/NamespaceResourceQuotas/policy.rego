package magalix.advisor.namespace.resource_quotas

resource_type := input.parameters.resource_type
namespace := input.parameters.namespace

violation[result] {
  rq_namespace := input.review.object.metadata.namespace
  rq_namespace == namespace
  not rq_spec.hard[resource_type]
  result = {
  	"issue detected": true,
    "msg": sprintf("You are missing '%v'", [resource_type]),
    "violating_key": "spec.hard"
  }
}

rq_spec = input.review.object.spec{
  contains_kind(input.review.object.kind, {"ResourceQuota"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
