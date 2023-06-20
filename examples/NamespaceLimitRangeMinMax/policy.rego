package weave.advisor.namespace.limitrange_min_max

resource_type := input.parameters.resource_type
resource_setting := input.parameters.resource_setting
namespace := input.parameters.namespace

violation[result] {
  values := lr_spec.limits[_]
  not values[resource_setting][resource_type]
  result = {
  	"issue_detected": true,
    "msg": sprintf("You are missing '%v': '%v'", [resource_setting, resource_type]),
    "violating_key": "spec.limits"

  }
}

lr_spec = input.review.object.spec {
  contains_kind(input.review.object.kind, {"LimitRange"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
