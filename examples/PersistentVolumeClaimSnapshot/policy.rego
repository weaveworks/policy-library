package weave.advisor.storage.persistentvolumeclaim_snapshot

snapshot_class := input.parameters.snapshot_class
pvc_name := input.parameters.pvc_name
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  snapshot := volume_spec.volumeSnapshotClassName
  not snapshot == snapshot_class
  result = {
	"issue detected": true,
    "msg": sprintf("VolumeSnapshotClassName names should be '%v', detected '%v'",[snapshot_class, snapshot]),
    "violating_key": "spec.volumeSnapshotClassName",
    "recommended_value": snapshot_class
	}
}

violation[result] {
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  claim_name := volume_spec.source.persistentVolumeClaimName
  not claim_name == pvc_name
  result = {
	"issue": true,
    "msg": sprintf("PVC names should be '%v', detected '%v'",[pvc_name, claim_name]),
    "violating_key": "spec.source.persistentVolumeClaimName"
	}
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
volume_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"VolumeSnapshot"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
