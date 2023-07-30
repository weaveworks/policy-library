package weave.advisor.bucket_approved_region

import future.keywords.in

exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value
regions := input.parameters.regions

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    not controller_spec.region in regions
    result = {
        "issue_detected": true,
        "msg": sprintf("The Bucket '%s' region must be one of the approved regions: %v; found '%s'", [controller_input.metadata.name, regions, controller_spec.region]),
        "violating_key": "spec.region"
    }
}

# Controller input
controller_input = input.review.object

# controller_spec acts as an iterator to get the spec from the input object
controller_spec = controller_input.spec {
  controller_input.kind == "Bucket"
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
