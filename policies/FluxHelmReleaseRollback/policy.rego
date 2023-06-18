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
        "issue_detected": true,
        "msg": "The HelmRelease rollback must be disabled; some rollback options are enabled.",
        "recommended_value": false,
        "violating_key": "spec.rollback"
    }
}

rollback_is_enabled(rollback) {
    rollback.disableWait == true
} else = true {
    rollback.disableHooks == true
} else = true {
    rollback.recreate == true
} else = true {
    rollback.force == true
} else = true {
    rollback.cleanupOnFail == true
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
