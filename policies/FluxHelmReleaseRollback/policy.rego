package weave.advisor.helm_release_rollback

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    rollback_is_enabled(controller_spec.rollback)
    result = {
        "issue detected": true,
        "msg": "The HelmRelease rollback must be disabled; some rollback options are enabled.",
        "recommended_value": false,
        "violating_key": "spec.rollback"
    }
}

rollback_is_enabled(rollback) {
    rollback.DisableWait == true
} else = true {
    rollback.DisableHooks == true
} else = true {
    rollback.Recreate == true
} else = true {
    rollback.Force == true
} else = true {
    rollback.CleanupOnFail == true
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
