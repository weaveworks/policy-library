package magalix.advisor.images.image_name_enforce

test_allowed_image {
	testcase = {
		"parameters": {
			"restricted_image_names": [
        "this_should_pass"
      ],
			"exclude_namespace": "",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {"object": {
			"apiVersion": "apps/v1",
			"kind": "Deployment",
			"metadata": {
				"name": "demoservice",
				"labels": {
					"app": "demoservice",
					"owner": "magalix",
				},
			},
			"spec": {
				"replicas": 1,
				"selector": {"matchLabels": {"app": "demoservice"}},
				"template": {
					"metadata": {"labels": {"app": "demoservice"}},
					"spec": {
						"containers": [
							{
								"name": "demoservice",
								"command": [
									"node",
									"app.js",
								],
								"image": "airwavetechio/demoservice:v0.0.2",
								"imagePullPolicy": "Always",
								"env": [{
									"name": "PORT",
									"value": "5000",
								}],
								"ports": [{
									"containerPort": 5000,
									"name": "liveness-port",
								}],
								"livenessProbe": {
									"httpGet": {
										"path": "/",
										"port": "liveness-port",
									},
									"initialDelaySeconds": 3,
									"periodSeconds": 5,
								},
								"readinessProbe": {
									"httpGet": {
										"path": "/",
										"port": "liveness-port",
									},
									"initialDelaySeconds": 3,
									"periodSeconds": 5,
								},
								"resources": {
									"limits": {
										"cpu": "10m",
										"memory": "25Mi",
									},
									"requests": {
										"cpu": "10m",
										"memory": "25Mi",
									},
								},
							},
							{
								"name": "demoservice",
								"command": [
									"node",
									"app.js",
								],
								"image": "airwavetechio/demoservice:latest",
								"imagePullPolicy": "Always",
								"env": [{
									"name": "PORT",
									"value": "5000",
								}],
								"ports": [{
									"containerPort": 5000,
									"name": "liveness-port",
								}],
								"livenessProbe": {
									"httpGet": {
										"path": "/",
										"port": "liveness-port",
									},
									"initialDelaySeconds": 3,
									"periodSeconds": 5,
								},
								"readinessProbe": {
									"httpGet": {
										"path": "/",
										"port": "liveness-port",
									},
									"initialDelaySeconds": 3,
									"periodSeconds": 5,
								},
								"resources": {
									"limits": {
										"cpu": "10m",
										"memory": "25Mi",
									},
									"requests": {
										"cpu": "10m",
										"memory": "25Mi",
									},
								},
							},
						],
						"restartPolicy": "Always",
					},
				},
			},
		}},
	}
	count(violation) == 0 with input as testcase
}
