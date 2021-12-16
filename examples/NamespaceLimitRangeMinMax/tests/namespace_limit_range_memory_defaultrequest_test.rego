package magalix.advisor.namespace.limitrange_min_max

test_memory_defaultrequest {
	testcase = {
        "parameters": {
            "resource_type": "memory",
            "resource_setting": "defaultRequest"
        },
        "review": {
            "object": {
                "apiVersion": "v1",
                "kind": "LimitRange",
                "metadata": {
                    "name": "default-limit-range"
                },
                "spec": {
                    "limits": [
                        {
                            "default": {
                            "cpu": 1,
                            "memory": "512Mi"
                            },
                            "defaultRequest": {
                            "cpu": 0.5,
                            "memory": "256Mi"
                            },
                            "max": {
                            "cpu": "800m",
                            "memory": "1Gi"
                            },
                            "min": {
                            "cpu": "200m",
                            "memory": "500Mi"
                            },
                            "type": "Container"
                        }
                    ]
                }
            }
        }
    }

	count(violation) == 0 with input as testcase
}