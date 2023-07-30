package weave.advisor.nodes.os_version

desired_os := input.parameters.os
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == node_metadata.labels[exclude_label_key]
  current_os := node_status.nodeInfo.osImage
  not current_os == desired_os
  result = {
    "issue_detected": true,
    "msg": sprintf("Node OS should be'%v'; found %v", [desired_os, current_os]),
    "violating_key": "status.nodeInfo.osImage"
  }
}

node_metadata = input.review.object.metadata {
  contains_kind(input.review.object.kind, {"Node"})
}

node_status = input.review.object.status {
  contains_kind(input.review.object.kind, {"Node"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
