package weave.advisor.ocirepository_ignore_suffixes

import future.keywords.in

suffixes := input.parameters.suffixes
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
    isExcludedNamespace == false
    not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
    ignore := split(controller_spec.ignore, "\n")
    not all_lines_have_allowed_suffixes(ignore, suffixes)
    result = {
        "issue_detected": true,
        "msg": sprintf("The OCIRepository '%s' must only include allowed suffixes in the ignore field. Allowed suffixes: %v", [controller_input.metadata.name, suffixes]),
        "violating_key": "spec.ignore"
    }
}

all_lines_have_allowed_suffixes(ignore, suffixes) {
    not any_line_with_unallowed_suffix(ignore, suffixes)
}

any_line_with_unallowed_suffix(ignore, suffixes) {
    line := ignore[_]
    is_extension_pattern(line)
    not line_has_allowed_suffix(line, suffixes)
}

line_has_allowed_suffix(line, suffixes) {
    suffix := suffixes[_]
    endswith(line, suffix)
}

is_extension_pattern(line) {
    # Check if the line has a file extension pattern (e.g., "*.md" or "/**/*.txt")
    re_match(`.*\*\.[a-zA-Z0-9]+`, line)
}

controller_input = input.review.object

controller_spec = controller_input.spec {
    controller_input.kind == "OCIRepository"
}

isExcludedNamespace = true {
    controller_input.metadata.namespace
    controller_input.metadata.namespace in exclude_namespaces
} else = false
