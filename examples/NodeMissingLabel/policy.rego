package weave.advisor.nodes.label

label := input.parameters.node_label
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == node_metadata.labels[exclude_label_key]
	node_labels := node_metadata.labels
	not node_labels[label]
  result = {
    "issue_detected": true,
    "msg": sprintf("Node is missing label '%v'; found %v", [label, node_metadata.labels]),
    "violating_key": "metadata.labels"
  }
}

node_metadata = input.review.object.metadata {
  contains_kind(input.review.object.kind, {"Node"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
