    package weave.advisor.kustomization_images_requirement

    import future.keywords.in

    exclude_namespaces := input.parameters.exclude_namespaces
    exclude_label_key := input.parameters.exclude_label_key
    exclude_label_value := input.parameters.exclude_label_value
    images_required := input.parameters.images_required

    violation[result] {
      isExcludedNamespace == false
      not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
      hasImages := object_has_images(controller_spec)
      hasImages != images_required
      result = {
        "issue_detected": true,
        "msg": "The 'spec.images' field in a Kustomization object must be  based on the policy input.",
        "violating_key": "spec.images"
      }
    }

    object_has_images(spec) {
      count(spec.images) > 0
    } else = false

    # Controller input
    controller_input = input.review.object

    # controller_spec acts as an iterator to get spec from the Kustomization object
    controller_spec = controller_input.spec {
      controller_input.kind == "Kustomization"
    }

    isExcludedNamespace = true {
      controller_input.metadata.namespace
      controller_input.metadata.namespace in exclude_namespaces
    } else = false