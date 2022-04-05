package weave.advisor.namespace.resource_quotas

test_limits_memory {
	testcase = {
        "parameters": {
            "resource_type": "limits.memory",
            "namespace": "magalix"
        },
        "review": {
            "object": {
                "apiVersion": "v1",
                "kind": "ResourceQuota",
                "metadata": {
                    "name": "mem-cpu-demo",
                    "namespace": "magalix"
                },
                "spec": {
                    "hard": {
                        "requests.cpu": "1",
                        "requests.memory": "1Gi",
                        "limits.cpu": "2",
                        "limits.memory": "2Gi"
                    }
                }
            }
        }
    }

	count(violation) == 0 with input as testcase
}