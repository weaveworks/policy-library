package weave.advisor.helm_release_post_renderer

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    hasPostRenderer := object.get(controller_spec, "postRenderers", false)
    hasPostRenderer != false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' must not have post-renderers enabled.", [controller_input.metadata.name]),
        "violating_key": "spec.postRenderers"
    }
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
