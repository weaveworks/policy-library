package weave.advisor.kustomization_patches

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
patches_required := input.parameters.patches_required

violation[result] {
  isExcludedNamespace == false
  has_patches := object_has_patches(controller_spec)

  not patches_required == has_patches
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]

  result = {
    "issue detected": true,
    "msg": sprintf("Kustomization patches should be %s, but it is %s", [
      bool_to_present_tense(patches_required),
      bool_to_present_tense(has_patches)
    ]),
    "violating_key": "spec.patches"
  }
}

# Check if the Kustomization object has patches defined in the spec
object_has_patches(spec) {
  count(spec.patches) > 0
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "Kustomization"
}

contains_kind(kind, kinds) {
    kinds[_] = kind
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false

bool_to_present_tense(b) {
  b == true
  "enabled"
} else = "disabled" {
  b == false
}
