package weave.advisor.containers.block_port

test_exclude_label {
	testcase = {
		"parameters": {
			"container_port": 22,
			"exclude_namespaces": [],
			"exclude_label_key": "allow-ssh",
			"exclude_label_value": "true",
		},
		"review": {
			"object": {
				"apiVersion": "apps/v1",
				"kind": "Deployment",
				"metadata": {
					"name": "my-nginx",
					"labels": {
						"allow-ssh": "true"
					}
				},
				"spec": {
					"selector": {
						"matchLabels": {
							"run": "my-nginx"
						},
					},
					"replicas": 2,
					"template": {
						"metadata": {
							"labels": {
								"run": "my-nginx"
							},
						},
						"spec": {
							"containers": [{
								"name": "my-nginx",
								"image": "nginx",
								"ports": [{
									"containerPort": 22
								}],
							}]
						},
					},
				},
			}
		},
	}

	count(violation) == 0 with input as testcase
}
