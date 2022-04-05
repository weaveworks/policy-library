package weave.advisor.labels.missing_kubernetes_app_part_of_label

test_k8s_part_of_exists {
	testcase = {
		"parameters": {
			"label": "app.kubernetes.io/part-of",
			"exclude_namespace": "",
			"exclude_label_key": "",
			"exclude_label_value": "",
		},
		"review": {
      "object": {
		  	"apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
          "name": "demoservice",
          "labels": {
            "app": "demoservice",
            "owner": "tony2",
            "app.kubernetes.io/part-of": "name"
          },
        },
        "spec": {
          "replicas": 1,
          "selector": {"matchLabels": {"app": "demoservice"}},
          "template": {
            "metadata": {"labels": {"app": "demoservice"}},
            "spec": {
              "securityContext": {
                "runAsUser": 0,
                "runAsGroup": 1000,
                "fsGroup": 1000,
                "runAsNonRoot": false,
              },
              "containers": [{
                "name": "demoservice",
                "command": [
                  "node",
                  "app.js",
                ],
                "image": "airwavetechio/demoservice:v0.0.2",
                "env": [{
                  "name": "PORT",
                  "value": "5001",
                }],
                "ports": [{
                  "containerPort": 5001,
                  "name": "liveness-port",
                }],
                "securityContext": {
                  "privileged": true,
                  "allowPrivilegeEscalation": true,
                  "readOnlyRootFilesystem": false,
                  "runAsUser": 1000,
                  "runAsGroup": 1000,
                  "runAsNonRoot": true,
                  "capabilities": {"add": ["SYS_ADMIN"]},
                },
              }],
            },
          },
        }
		  }
    }
	}

	count(violation) == 0 with input as testcase
}
