package weave.advisor.storage.persistentvolume_acccess_mode

access_mode := input.parameters.access_mode
name := input.parameters.name

violation[result] {
  spec_name := controller_input.metadata.name
  spec_name == name
  spec_access_modes := storage_spec.accessModes
  not array_contains(spec_access_modes, access_mode)
  result = {
    "issue_detected": true,
    "msg": sprintf("Access Modes should contain '%v'; found '%v'", [access_mode, spec_access_modes]),
    "violating_key": "spec.accessModes"
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
storage_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"PersistentVolume"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
