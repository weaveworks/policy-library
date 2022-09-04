package weave.advisor.podSecurity.runningAsUser

test_pod_violating_runAsUser {
  testcase = {
    "parameters": {
      "exclude_namespaces": [],
      "uid": 0,
      "exclude_label_key": "",
      "exclude_label_value": "",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
          "name": "security-context-demo",
        },
        "spec": {
          "securityContext" : {
            "runAsUser": 0,
          },
          "containers": [
            {
              "securityContext" : {
                "runAsUser": 1000,
                "runAsNonRoot": true,
              },
              "name": "sec-ctx-demo",
              "image": "busybox",
              "command": [
                "sh",
                "-c",
                "sleep 1h"
              ],
            },
            {
              "securityContext" : {
                "runAsUser": 1000,
                "runAsNonRoot": true,
              },
              "name": "sec-ctx-demo2",
              "image": "busybox",
              "command": [
                "sh",
                "-c",
                "sleep 1h"
              ],
            }
          ]
        }
      }
    }
  }

  count(violation) == 1 with input as testcase
}