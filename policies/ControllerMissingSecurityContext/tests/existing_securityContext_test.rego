package weave.advisor.podSecurity.missing_security_context

test_existing_security_context {
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
          "name": "security-context",
        },
        "spec": {
          "containers": [
            {
              "name": "sec-ctx",
			        "securityContext" : {
                "runAsNonRoot": true,
                "runAsUser": 1000,
              },
              "image": "busybox",
              "command": [
                "sh",
                "-c",
                "sleep 1h"
              ],
            },
            {
              "name": "sec-ctx2",
			        "securityContext" : {
                "runAsNonRoot": true,
                "runAsUser": 1000,
              },
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