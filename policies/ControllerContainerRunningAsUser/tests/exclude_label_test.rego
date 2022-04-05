package weave.advisor.podSecurity.runningAsUser

test_exclude_label {
  testcase = {
    "parameters": {
      "exclude_namespace": "",
      "uid": 0,
      "exclude_label_key": "allow-root",
      "exclude_label_value": "true",
    },
    "review": {
      "object": {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
          "name": "security-context-demo",
          "labels": {
            "allow-root": "true"
          },
        },
        "spec": {
          "securityContext" : {
            "runAsUser": 0,
          },
          "containers": [
            {
              "securityContext" : {
                "runAsUser": 0,
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
                "runAsUser": 0,
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

  count(violation) == 0 with input as testcase
}