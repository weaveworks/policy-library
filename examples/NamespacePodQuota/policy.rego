package magalix.advisor.namespace.pod_quotas

pod_quota := input.parameters.pod_quota

violation[result] {
  pods := rq_spec.hard.pods
  not pods <= pod_quota
  result = {
  	"issue detected": true,
    "msg": "You are missing the number of Pods",
    "violating_key": "spec.hard.pods"
  }
}

rq_spec = input.review.object.spec{
  contains_kind(input.review.object.kind, {"ResourceQuota"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
