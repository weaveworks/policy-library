package magalix.advisor.nodes.custom_node_label

key := input.parameters.key
value := input.parameters.value
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == node_metadata.labels[exclude_label_key]
  not node_metadata.labels[key]
  result = {
 	"issue_detected": true,
    "msg": sprintf("Node is missing key '%v'; found %v", [key, node_metadata.labels]),
    "violating_key": "metadata.labels"
  }
}

violation[result] {
  not exclude_label_value == node_metadata.labels[exclude_label_key]
  label_value := node_metadata.labels[key]
  not value == label_value
  result = {
  	"issue_detected": true,
    "msg": sprintf("Node label '%v' should have the value of '%v'; found '%v'", [key, value, label_value]),
    "violating_key": sprintf("metadata.labels[%v]", [key]),
    "recommended_value": value
  }
}

node_metadata = input.review.object.metadata {
	contains_kind(input.review.object.kind, {"Node"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
