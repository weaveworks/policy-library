package magalix.advisor.istio.approved_hosts

test_key_value_exists {
	testcase = {
        "parameters": {
            "hostnames": [
                "console.gcp.dev.magalix.com",
            ],
            "exclude_namespace": "",
            "exclude_label_key": "",
            "exclude_label_value": "",
        },
        "review": {
            "object": {
                "kind": "Gateway",
                "apiVersion": "networking.istio.io/v1alpha3",
                "metadata": {
                    "name": "console",
                    "namespace": "magalix"
                },
                "spec": {
                    "selector": {
                        "istio": "ingressgateway"
                    },
                    "servers": [
                        {
                            "hosts": [
                                "console.gcp.dev.magalix.com"
                            ],
                            "port": {
                                "name": "https",
                                "number": 443,
                                "protocol": "HTTPS"
                            },
                            "tls": {
                                "credentialName": "console",
                                "mode": "SIMPLE"
                            }
                        },
                        {
                            "hosts": [
                                "console.gcp.dev.magalix.com"
                            ],
                            "port": {
                                "name": "http",
                                "number": 80,
                                "protocol": "HTTP"
                            },
                            "tls": {
                                "httpsRedirect": true
                            }
                        }
                    ]
                }
            }
        }
    }

	count(violation) == 0 with input as testcase
}