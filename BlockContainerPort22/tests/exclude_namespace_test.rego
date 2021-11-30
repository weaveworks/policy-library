package magalix.advisor.containers.block_port

test_exclude_namespace {
	testcase = {
		"parameters": {
			"container_port": 22,
			"exclude_namespace": "allow-ssh",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {
			"object": {
				"apiVersion": "apps/v1",
				"kind": "Deployment",
				"metadata": {
					"name": "my-nginx",
					"namespace": "allow-ssh",
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
