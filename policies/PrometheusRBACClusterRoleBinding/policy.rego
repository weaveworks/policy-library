package weave.advisor.rbac.prometheus_server_clusterrolebrinding

subject_name := input.parameters.prometheus_subject_name
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

vviolation[result] {
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  contains(crb_input.metadata.name, "prometheus")
  some i
  subjects = crb_input.subjects[i]
  not subjects.kind == "ServiceAccount"
  result = {
    "issue_detected": true,
    "msg": sprintf("subject kind must be ServiceAccount; found '%v'", [subjects.kind]),
    "violating_key": sprintf("subjects[%v].kind", [i])
  }
}

violation[result] {
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  contains(crb_input.metadata.name, "prometheus")
  some i
  subjects = crb_input.subjects[i]
  not contains(subjects.name, subject_name)
  result = {
    "issue_detected": true,
    "msg": sprintf("subject name must contain '%v'; found '%v'", [subject_name, subjects.name]),
    "violating_key": sprintf("subjects[%v].name", [i]),
    "recommended_value": subject_name
  }
}

violation[result] {
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  contains(crb_input.metadata.name, "prometheus")
  contains(crb_input.metadata.name, "prometheus")
  not contains(crb_input.roleRef.kind, "ClusterRole")
  result = {
    "issue_detected": true,
    "msg": sprintf("roleRef kind must contain be a Role or ClusterRole; found '%v'", [crb_input.roleRef.kind]),
    "violating_key": "roleRef.kind"
  }
}

violation[result] {
  not exclude_label_value == crb_input.metadata.labels[exclude_label_key]
  contains(crb_input.metadata.name, "prometheus")
  contains(crb_input.metadata.name, "prometheus")
  not contains(crb_input.roleRef.name, "prometheus")
  result = {
    "issue_detected": true,
    "msg": sprintf("roleRef name must contain prometheus; found '%v'", [crb_input.roleRef.name]),
    "violating_key": "roleRef.name"
  }
}

crb_input = input.review.object {
  contains_kind(input.review.object.kind, {"ClusterRoleBinding"})
} 

contains_kind(kind, kinds) {
  kinds[_] = kind
}
