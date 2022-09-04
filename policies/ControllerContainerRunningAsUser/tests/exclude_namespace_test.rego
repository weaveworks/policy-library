package weave.advisor.podSecurity.runningAsUser

test_exclude_namespace {
  testcase = {
    "parameters": {
      "exclude_namespaces": ["allow-root"],
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
          "namespace": "allow-root",
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