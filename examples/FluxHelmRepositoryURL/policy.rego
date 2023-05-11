package weave.advisor.helm_repo_url

import future.keywords.in

domains := input.parameters.domains
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    repository_url := controller_spec.url
    not domain_matches(repository_url, domains)
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRepository URL must be from one of the allowed domains '%s'; found '%s'", [domains, repository_url]),
        "violating_key": "spec.url"
    }
}

domain_matches(url, domains) {
    startswith(url, "https://")
    parts := split(url, "/")
    count(parts) > 2
    domain := parts[2]
    domain in domains
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec {
  controller_input.kind == "HelmRepository"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
