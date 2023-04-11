package weave.advisor.helm_repo_url

import future.keywords.in

domain := input.parameters.domain
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    repository_url := controller_spec.url
    not startswith(repository_url, sprintf("https://%s", [domain]))
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRepo URL must be from the organization domain '%v'; found '%v'", [domain, repository_url]),
        "violating_key": "spec.url"
    }
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmRepo"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
