package weave.advisor.storage.persistentvolume_reclaim_policy

policy := input.parameters.pv_policy
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  pv_policy := storage_spec.persistentVolumeReclaimPolicy
  not pv_policy == policy
  result = {
    "issue_detected": true,
    "msg": sprintf("persistentVolumeReclaimPolicy must be '%v'; found '%v'", [policy, pv_policy]),
    "violating_key": "spec.persistentVolumeReclaimPolicy",
    "recommened_value": policy
  }
}

# controller_container acts as an iterator to get containers from the template
storage_spec = input.review.object.spec {
  contains_kind(input.review.object.kind, {"PersistentVolume"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

