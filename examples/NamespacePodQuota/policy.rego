package magalix.advisor.namespace.pod_quotas

pod_quota := input.parameters.pod_quota
namespace := input.parameters.namespace

violation[result] {
  rq_namespace := input.review.object.metadata.namespace
  rq_namespace == namespace
  pods := rq_spec.hard.pods
  not pods <= pod_quota
  result = {
  	"issue detected": true,
    "msg": sprintf("The numbers of pods should be '%v' or greater; detected '%v'", [pod_quota, pods]),
    "violating_key": "spec.hard.pods"
  }
}

rq_spec = input.review.object.spec{
  contains_kind(input.review.object.kind, {"ResourceQuota"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
