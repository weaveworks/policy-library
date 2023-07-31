package weave.advisor.pods.containers_not_namespace

import data.weave.advisor.pods.containers_not_namespace.violation

test_valid_case {
  testcase = {
    "parameters": {
      "custom_namespace": "flux-system",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
       "apiVersion": "v1",
       "kind": "Pod",
       "metadata": {
         "name": "pod-execution-escalation",
         "namespace": "default"
       },
       "spec": {
         "containers": [
           {
             "name": "attack-container",
             "image": "busybox:1.36",
             "command": [
               "sleep"
             ],
             "args": [
               "infinity"
             ]
           }
         ]
       }
      }
    }
  }

  count(violation) == 0 with input as testcase
}

test_invalid_pod {
  testcase = {
    "parameters": {
      "custom_namespace": "default",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
       "apiVersion": "v1",
       "kind": "Pod",
       "metadata": {
         "name": "pod-execution-escalation",
         "namespace": "default"
       },
       "spec": {
         "containers": [
           {
             "name": "attack-container",
             "image": "busybox:1.36",
             "command": [
               "sleep"
             ],
             "args": [
               "infinity"
             ]
           }
         ]
       }
      }
    }
  }

  count(violation) == 1 with input as testcase
}

test_invalid_deployment {
  testcase = {
    "parameters": {
      "custom_namespace": "default",
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
      "apiVersion": "apps/v1",
      "kind": "Deployment",
      "metadata": {
        "name": "demoservice",
        "namespace": "default",
        "labels": {
          "app.kubernetes.io/name": "demoservice",
          "app": "demoservice",
          "owner": "tony"
        }
      },
      "spec": {
        "replicas": 2,
        "selector": {
          "matchLabels": {
            "app": "demoservice"
          }
        },
        "template": {
          "metadata": {
            "labels": {
              "app": "demoservice"
            }
          },
          "spec": {
            "containers": [
              {
                "name": "demoservice",
                "command": [
                  "node",
                  "app.js"
                ],
                "image": "airwavetechio/demoservice:v0.0.2",
                "env": [
                  {
                    "name": "PORT",
                    "value": "5000"
                  }
                ],
                "ports": [
                  {
                    "containerPort": 5000,
                    "name": "liveness-port"
                  }
                ],
                "livenessProbe": {
                  "httpGet": {
                    "path": "/",
                    "port": "liveness-port"
                  },
                  "initialDelaySeconds": 3,
                  "periodSeconds": 5
                },
                "readinessProbe": {
                  "httpGet": {
                    "path": "/",
                    "port": "liveness-port"
                  },
                  "initialDelaySeconds": 3,
                  "periodSeconds": 5
                },
                "resources": {
                  "limits": {
                    "cpu": "10m",
                    "memory": "25Mi"
                  },
                  "requests": {
                    "cpu": "10m",
                    "memory": "25Mi"
                  }
                }
              },
              {
                "name": "demoservice",
                "command": [
                  "node",
                  "app.js"
                ],
                "image": "airwavetechio/demoservice:v0.0.2",
                "env": [
                  {
                    "name": "PORT",
                    "value": "5000"
                  }
                ],
                "ports": [
                  {
                    "containerPort": 5000,
                    "name": "liveness-port"
                  }
                ],
                "livenessProbe": {
                  "httpGet": {
                    "path": "/",
                    "port": "liveness-port"
                  },
                  "initialDelaySeconds": 3,
                  "periodSeconds": 5
                },
                "readinessProbe": {
                  "httpGet": {
                    "path": "/",
                    "port": "liveness-port"
                  },
                  "initialDelaySeconds": 3,
                  "periodSeconds": 5
                },
                "resources": {
                  "limits": {
                    "cpu": "10m",
                    "memory": "25Mi"
                  },
                  "requests": {
                    "cpu": "10m",
                    "memory": "25Mi"
                  }
                }
              }
            ],
            "restartPolicy": "Always"
          }
        }
      }
     }
    }
  }

  count(violation) == 1 with input as testcase
}
