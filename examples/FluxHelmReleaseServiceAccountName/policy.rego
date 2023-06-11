package weave.advisor.helm_release_service_account_name

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
service_account_names := input.parameters.service_account_names

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    service_account_name := controller_spec.serviceAccountName
    not service_account_name in service_account_names
    result = {
        "issue detected": true,
        "msg": sprintf("The HelmRelease '%s' serviceAccountName must contain a value from parameters.service_account_names; found '%s'", [controller_input.metadata.name, service_account_name]),
        "violating_key": "spec.serviceAccountName"
    }
}

controller_input = input.review.object

controller_spec = controller_input.spec {
  controller_input.kind == "HelmRelease"
}

isExcludedNamespace = true {
  controller_input.metadata.namespace
  controller_input.metadata.namespace in exclude_namespaces
} else = false
