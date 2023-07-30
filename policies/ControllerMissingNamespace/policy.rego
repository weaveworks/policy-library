package weave.advisor.namespace.missing_namespace

exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  not controller_input.metadata.namespace
  result = {
  	"issue_detected": true,
    "msg": sprintf("Missing namespace. Workloads should be deployed in a non-default namespace;",[]),
    "violating_key": "metadata"
  }
}

controller_input = input.review.object
