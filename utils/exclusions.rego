package exclusions

import data.utils

excludeNamespace(exclude_namespace) {
	exclude_namespace == utils.controller_input.metadata.namespace
}

excludeLabel(exclude_label_key, exclude_label_value) {
	exclude_label_value == utils.controller_input.metadata.labels[exclude_label_key]
}
