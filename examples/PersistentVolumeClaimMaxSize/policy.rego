package weave.advisor.storage.persistentvolumeclaim_max_size

max_size := input.parameters.size
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  storage_value := storage_spec.resources.requests.storage
  unit_type_value := units.parse_bytes(storage_value)
  unit_max_value := units.parse_bytes(max_size)
  unit_max_value < unit_type_value
  result = {
    "issue detected": true,
    "msg": sprintf("Storage must be a maximum of '%v'; found '%v'", [max_size, storage_value]),
    "violating_key": "spec.spec.resources.requests.storage"
  }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
storage_spec = controller_input.spec {
  contains_kind(controller_input.kind, {"PersistentVolumeClaim"})
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}
