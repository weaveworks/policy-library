package weave.advisor.kustomization_var_substitution

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    var_sub_enabled := controller_spec.postBuild.substitute.var_substitution_enabled
    var_sub_enabled
    result = {
        "issue_detected": true,
        "msg": sprintf("The Kustomization '%s' spec.postBuild.substitute.var_substitution_enabled must be disabled", [controller_input.metadata.name]),
        "violating_key": "spec.postBuild.substitute.var_substitution_enabled",
        "recommended_value": false
    }
}

controller_input = input.review.object

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
