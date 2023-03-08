## Mongo-Express Enforce Environment Variable - ME_CONFIG_MONGODB_ADMINUSERNAME

### ID
weave.policies.mongo-express-enforce-admin-username-env-var

### Description
This Policy ensures ME_CONFIG_MONGODB_ADMINUSERNAME environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_MONGODB_ADMINUSERNAME: The ME_CONFIG_MONGODB_ADMINUSERNAME environment variable sets the MongoDB admin username.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_MONGODB_ADMINUSERNAME environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MYSQL_DATABASE

### ID
weave.policies.mariadb-enforce-mysql-database-env-var

### Description
This Policy ensures MYSQL_DATABASE environment variable are in place when using the official container images from Docker Hub.
MYSQL_DATABASE:   The MYSQL_DATABASE environment variable sets a default MARIADB database instance up with the name of that DB being the value of  environment variable. 


### How to solve?
If you encounter a violation, ensure the MYSQL_DATABASE environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Missing Security Context

### ID
weave.policies.containers-missing-security-context

### Description
This Policy checks if the container is missing securityContext while there is no securityContext defined on the Pod level as well. The security settings that are specified on the Pod level apply to all containers in the Pod.


### How to solve?
Make sure you secure your containers by specifying a `securityContext` whether on each container or on the Pod level. The security settings that you specify on the Pod level apply to all containers in the Pod.
```
...
  spec:
    securityContext:
      <securityContext attributes>
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': ['kube-system']}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Minimum Replica Count

### ID
weave.policies.containers-minimum-replica-count

### Description
Use this Policy to to check the replica count of your workloads. The value set in the Policy is greater than or equal to the amount desired, so if the replica count is lower than what is specified, the Policy will be in violation. 


### How to solve?
The replica count should be a value equal or greater than what is set in the Policy.
```
spec:
  replicas: <replica_count>
```
https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#scaling-a-deployment


### Category
weave.categories.reliability

### Severity
medium

### Targets
{'kinds': ['Deployment', 'StatefulSet', 'ReplicaSet', 'ReplicationController', 'HorizontalPodAutoscaler']}

### Tags
['soc2-type1']

### Parameters
[{'name': 'replica_count', 'type': 'integer', 'required': True, 'value': 2}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MYSQL_ROOT_PASSWORD

### ID
weave.policies.mariadb-enforce-mysql-root-password-env-var

### Description
This Policy ensures MYSQL_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_ROOT_PASSWORD: The MYSQL_ROOT_PASSWORD environment variable specifies a password for the MARIADB root account. 


### How to solve?
If you encounter a violation, ensure the MYSQL_ROOT_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MYSQL_INITDB_SKIP_TZINFO

### ID
weave.policies.mariadb-enforce-mysql-initdb-skip-tzinfo-env-var

### Description
This Policy ensures MYSQL_INITDB_SKIP_TZINFO environment variable are in place when using the official container images from Docker Hub.
MYSQL_INITDB_SKIP_TZINFO:   The MYSQL_INITDB_SKIP_TZINFO environment variable allows the skipping of timezone checking when initializing the DB.


### How to solve?
If you encounter a violation, ensure the MYSQL_INITDB_SKIP_TZINFO environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Prometheus Clusterrolebinding Has Incorrect Bindings

### ID
weave.policies.prometheus-clusterrolebinding-has-incorrect-bindings

### Description
This Policy checks to see if the Prometheus Cluster Role Binding is bound to a `ClusterRole`, and is tied to a `ServiceAccount` name containing text of your choosing. The default policy is set for search for the Service Account name containing the word `prometheus`. 


### How to solve?
Ensure the subject name you specify in the Policy matches what you are deploying. 
```
kind: ClusterRoleBinding
metadata:
  name: prometheus
...
subjects:
- kind: ServiceAccount
  name: prometheus
```
https://kubernetes.io/docs/reference/access-authn-authz/rbac/


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['ClusterRoleBinding']}

### Tags
['pci-dss', 'hipaa', 'soc2-type1']

### Parameters
[{'name': 'prometheus_subject_name', 'type': 'string', 'required': True, 'value': 'prometheus'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Deny Secrets not Encrypted or not using Flux Variable Substitution

### ID
weave.policies.secrets

### Description
Checks the secrets in the repo to make sure there are none with unencrypted data or that Substitute Variables are used.


### How to solve?
Please recreate the secret data and encrypt the secret file using the appropriate commmands.


### Category
weave.categories.secrets

### Severity
critical

### Targets
{'kinds': ['Secret']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': 'weave.policies.secrets'}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': 'ignore'}]

---

## MongoDB Enforce Environment Variable - MONGO_INITDB_ROOT_USERNAME_FILE

### ID
weave.policies.mongodb-enforce-root-username-file-env-var

### Description
This Policy ensures MONGO_INITDB_ROOT_USERNAME_FILE environment variable are in place when using the official container images from Docker Hub.
MONGO_INITDB_ROOT_USERNAME_FILE: The MONGO_INITDB_ROOT_USERNAME_FILE environment variable is an alternative to passing sensitive information via environment variables, _FILE may be appended to the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container.


### How to solve?
If you encounter a violation, ensure the MONGO_INITDB_ROOT_USERNAME_FILE environment variables is set.
For futher information about the MongoDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Sharing Host IPC

### ID
weave.policies.containers-sharing-host-ipc

### Description
This Policy allows check if sharing host IPC namespace with the container should be allowed or not. Resources that can be shared with the container include:

### hostNetwork
Controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.

### hostPID
Controls whether the pod containers can share the host process ID namespace. Note that when paired with ptrace this can be used to escalate privileges outside of the container (ptrace is forbidden by default).

### shareProcessNamespace
When process namespace sharing is enabled, processes in a container are visible to all other containers in that pod.

### hostIPC
Controls whether the pod containers can share the host IPC namespace.


### How to solve?
Match the shared resource with either true or false, as set in your constraint. 
```
...
  spec:
    <shared_resource>: <resource_enabled>
```
https://kubernetes.io/docs/concepts/policy/pod-security-policy/#host-namespaces


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'resource_enabled', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_PID_FILE

### ID
weave.policies.rabbitmq-enforce-pid-file-env-var

### Description
This Policy ensures RABBITMQ_PID_FILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_PID_FILE: File in which the process id is placed for use by rabbitmqctl wait.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_PID_FILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Services Prohibit Type

### ID
weave.policies.services-prohibit-type

### Description
This Policy checks your Kubernetes Service kind to see what Service type is set. If a specified service type is found, this Policy will be in violation. Security practices suggest using types `ServiceType` of `ClusterIP` or `LoadBalancer` and not `NodePort`. 


### How to solve?
Ensure the type matches what is specified in the Policy. 
```
spec:
  type: <type>
```

https://kubernetes.io/docs/concepts/services-networking/service/#nodeport


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Service']}

### Tags
['pci-dss']

### Parameters
[{'name': 'type', 'type': 'string', 'required': True, 'value': 'NodePort'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_RANDOM_ROOT_PASSWORD

### ID
weave.policies.mariadb-enforce-random-root-password-env-var

### Description
This Policy ensures MARIADB_RANDOM_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MARIADB_RANDOM_ROOT_PASSWORD:   The MARIADB_RANDOM_ROOT_PASSWORD environment variable creates random password for the server's root user when the Docker container is started.


### How to solve?
If you encounter a violation, ensure the MARIADB_RANDOM_ROOT_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_VM_MEMORY_HIGH_WATERMARK

### ID
weave.policies.rabbitmq-enforce-vm-memory-env-var

### Description
This Policy ensures RABBITMQ_VM_MEMORY_HIGH_WATERMARK environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_VM_MEMORY_HIGH_WATERMARK: The RABBITMQ_VM_MEMORY_HIGH_WATERMARK environment variable sets the memory threshold at which the flow control is triggered. Can be absolute or relative to the amount of RAM available to the OS.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_VM_MEMORY_HIGH_WATERMARK environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Services Prohibit Ports Range

### ID
weave.policies.services-prohibit-ports-range

### Description
This Policy checks if ports allocated for your services are using a number that is less than the specified value. 


### How to solve?
Use a port that is greater than or equal to what is specified in the Policy. 
```
spec:
  ports:
    - targetPort: <target_port>
```


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Service']}

### Tags
['pci-dss']

### Parameters
[{'name': 'target_port', 'type': 'integer', 'required': True, 'value': 1024}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_PLUGINS_EXPAND_DIR

### ID
weave.policies.rabbitmq-enforce-plugins-expand-dir-env-var

### Description
This Policy ensures RABBITMQ_PLUGINS_EXPAND_DIR environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_PLUGINS_EXPAND_DIR: Working directory used to expand enabled plugins when starting the server. It is important that effective RabbitMQ user has sufficient permissions to read and create files and subdirectories in this directory.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_PLUGINS_EXPAND_DIR environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_MNESIA_BASE

### ID
weave.policies.rabbitmq-enforce-mnesia-base-env-var

### Description
This Policy ensures RABBITMQ_MNESIA_BASE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_MNESIA_BASE: This base directory contains sub-directories for the RabbitMQ server's node database, message store and cluster state files, one for each node, unless RABBITMQ_MNESIA_DIR is set explicitly. It is important that effective RabbitMQ user has sufficient permissions to read, write and create files and subdirectories in this directory at any time. This variable is typically not overridden. Usually RABBITMQ_MNESIA_DIR is overridden instead.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_MNESIA_BASE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_DEPTH

### ID
weave.policies.rabbitmq-enforce-ssl-depth-env-var

### Description
This Policy ensures RABBITMQ_SSL_DEPTH environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_DEPTH: RABBITMQ_SSL_DEPTH is the maximum number of non-self-issued intermediate certificates that may follow the peer certificate in a valid certification path.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_DEPTH environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_INITDB_WALDIR

### ID
weave.policies.postgres-enforce-initdb-waldir-env-var

### Description
This Policy ensures POSTGRES_INITDB_WALDIR environment variable are in place when using the official container images from Docker Hub.
POSTGRES_INITDB_WALDIR: The POSTGRES_INITDB_WALDIR environment variable is used to define another location for the Postgres transaction log. By default the transaction log is stored in a subdirectory of the main Postgres data folder (PGDATA). 


### How to solve?
If you encounter a violation, ensure the POSTGRES_INITDB_WALDIR environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_PASSWORD

### ID
weave.policies.influxdb-enforce-password-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_PASSWORD: The password to set for the system's initial super-user (Required).


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_PASSWORD environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - PGDATA

### ID
weave.policies.postgres-enforce-pgdata-env-var

### Description
This Policy ensures PGDATA environment variable are in place when using the official container images from Docker Hub.
PGDATA: The PGDATA environment variable is used to define another location - like a subdirectory - for the database files. The default is /var/lib/postgresql/data. If the data volume you're using is a filesystem mountpoint (like with GCE persistent disks) or remote folder that cannot be chowned to the postgres user (like some NFS mounts), Postgres initdb recommends a subdirectory be created to contain the data.


### How to solve?
If you encounter a violation, ensure the PGDATA environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Running In Privileged Mode

### ID
weave.policies.containers-running-in-privileged-mode

### Description
This Policy reports if containers are running in privileged mode. A privileged container is given access to all devices on the host. This allows the container nearly all the same access as processes running on the host.

By default a container is not allowed to access any devices on the host, but a "privileged" container is given access to all devices on the host. This allows the container nearly all the same access as processes running on the host. This is useful for containers that want to use linux capabilities like manipulating the network stack and accessing devices.


### How to solve?
Look at the following path to see what the settings are. 
```
...
  spec:
    containers:
    - securityContext:
        privileged: <privilege>
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'soc2-type1', 'default']

### Parameters
[{'name': 'privilege', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_INITDB_SKIP_TZINFO

### ID
weave.policies.mariadb-enforce-initdb-skip-tzinfo-env-var

### Description
This Policy ensures MARIADB_INITDB_SKIP_TZINFO environment variable are in place when using the official container images from Docker Hub.
MARIADB_INITDB_SKIP_TZINFO:   The MARIADB_INITDB_SKIP_TZINFO environment variable allows the skipping of timezone checking when initializing the DB.


### How to solve?
If you encounter a violation, ensure the MARIADB_INITDB_SKIP_TZINFO environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Block Sysctls CVE-2022-0811

### ID
weave.policies.container-block-sysctl.cve-2022-0811

### Description
Setting sysctls can allow containers unauthorized escalated privileges to a Kubernetes node. 


### How to solve?
You should not set `securityContext.sysctls.value` to include `+` or `=` characters. 
```
...
  spec:
    securityContext:
      sysctls: 
        - name: name
          value "1+2=3"
```
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
https://www.crowdstrike.com/blog/cr8escape-new-vulnerability-discovered-in-cri-o-container-engine-cve-2022-0811/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': ['kube-system']}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MongoDB Enforce Environment Variable - MONGO_INITDB_ROOT_PASSWORD_FILE

### ID
weave.policies.mongodb-enforce-root-password-file-env-var

### Description
This Policy ensures MONGO_INITDB_ROOT_PASSWORD_FILE environment variable are in place when using the official container images from Docker Hub.
MONGO_INITDB_ROOT_PASSWORD_FILE: The MONGO_INITDB_ROOT_PASSWORD_FILE environment variable is an alternative to passing sensitive information via environment variables, _FILE may be appended to the previously listed environment variables, causing the initialization script to load the values for those variables from files present in the container.


### How to solve?
If you encounter a violation, ensure the MONGO_INITDB_ROOT_PASSWORD_FILE environment variables is set.
For futher information about the MongoDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_OPTIONS_EDITORTHEME

### ID
weave.policies.mongo-express-enforce-editor-theme-env-var

### Description
This Policy ensures ME_CONFIG_OPTIONS_EDITORTHEME environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_OPTIONS_EDITORTHEME: The ME_CONFIG_OPTIONS_EDITORTHEME environment variable sets the editor color theme, [more here](http://codemirror.net/demo/theme.html)


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_OPTIONS_EDITORTHEME environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_BASEURL

### ID
weave.policies.mongo-express-enforce-base-url-env-var

### Description
This Policy ensures ME_CONFIG_SITE_BASEURL environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_BASEURL: The ME_CONFIG_SITE_BASEURL environment variable sets the baseUrl to ease mounting at a subdirectory. Remember to include a leading and trailing slash.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_BASEURL environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Prohibit Environment Variable - MYSQL_ALLOW_EMPTY_PASSWORD

### ID
weave.policies.mysql-prohibit-empty-password-env-var

### Description
This Policy ensures MYSQL_ALLOW_EMPTY_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_ALLOW_EMPTY_PASSWORD: MYSQL_ALLOW_EMPTY_PASSWORD set to true will allow the container to be started with a blank password for the root user


### How to solve?
If you encounter a violation, ensure the MYSQL_ALLOW_EMPTY_PASSWORD environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Prohibit Creating Namespace Starting With Prefix

### ID
weave.policies.prohibit-creating-namespace-starting-with-prefix

### Description
Using this Policy, you can prohibit certain namespaces from containing a specified combination of letters and/or numbers. 


### How to solve?
Specify a `namespace` that is something other than what is listed in the Policy. 
```
metadata:
  name: <namespace_name>
```
https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/#working-with-namespaces


### Category
weave.categories.organizational-standards

### Severity
medium

### Targets
{'kinds': ['Namespace']}

### Tags
[]

### Parameters
[{'name': 'namespace_name', 'type': 'string', 'required': True, 'value': 'kube-'}]

---

## MariaDB Enforce Environment Variable - MYSQL_USER

### ID
weave.policies.mariadb-enforce-mysql-user-env-var

### Description
This Policy ensures MYSQL_USER environment variable are in place when using the official container images from Docker Hub.
MYSQL_USER: The MYSQL_USER environment variable sets up a superuser with the same name.


### How to solve?
If you encounter a violation, ensure the MYSQL_USER environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Block Workloads Created Without Specifying Namespace

### ID
weave.policies.block-workloads-created-without-specifying-namespace

### Description
Using this Policy, you can prohibit workloads from being created in a default namespace due to the lack of a namespace label. 


### How to solve?
Specify a `namespace` label. 
```
metadata:
  namespace:
```
https://kubernetes.io/docs/tasks/administer-cluster/namespaces/#understanding-the-motivation-for-using-namespaces


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_ORG

### ID
weave.policies.influxdb-enforce-org-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_ORG environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_ORG: The name to set for the system's initial organization (Required).


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_ORG environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Read Only Root Filesystem

### ID
weave.policies.containers-read-only-root-filesystem

### Description
This Policy will cause a violation if the root file system is not mounted as specified. As a security practice, the root file system should be read-only or expose risk to your nodes if compromised. 

This Policy requires containers must run with a read-only root filesystem (i.e. no writable layer).


### How to solve?
Set `readOnlyRootFilesystem` in your `securityContext` to the value specified in the Policy. 
```
...
  spec:
    containers:
      - securityContext:
          readOnlyRootFilesystem: <read_only>
```

https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['mitre-attack', 'nist800-190']

### Parameters
[{'name': 'read_only', 'type': 'boolean', 'required': True, 'value': True}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_KEYFILE

### ID
weave.policies.rabbitmq-enforce-ssl-keyfile-env-var

### Description
This Policy ensures RABBITMQ_SSL_KEYFILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_KEYFILE: The RABBITMQ_SSL_KEYFILE sets a path for the server private key file.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_KEYFILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MYSQL_RANDOM_ROOT_PASSWORD

### ID
weave.policies.mariadb-enforce-mysql-random-root-password-env-var

### Description
This Policy ensures MYSQL_RANDOM_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_RANDOM_ROOT_PASSWORD: The MYSQL_RANDOM_ROOT_PASSWORD environment variable creates random password for the server's root user when the Docker container is started.


### How to solve?
If you encounter a violation, ensure the MYSQL_RANDOM_ROOT_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Controller ServiceAccount Tokens Automount

### ID
weave.policies.controller-serviceaccount-tokens-automount

### Description
This Policy allows for the option of enabling or disabling Service Accounts that are created for a Pod. The recommended practice is to set the `automount_token` to `false.  

When a pod is created without specifying a service account, it is automatically assigned the default service account in the same namespace. This is a security concern because a compromised container can access the API using automatically mounted service account credentials. The API permissions of the service account depend on the authorization plugin and policy in use, but could possibly create and delete pods. 

We recommend setting the `automount_token` to `false`. 

In version 1.6+, you can opt out of automounting API credentials for a particular pod.


### How to solve?
Ensure the setting in the Policy matches the Service Account declaration in the controller. 
```
...
  spec:
    automountServiceAccountToken: false
```

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'hipaa', 'gdpr', 'default', 'soc2-type1']

### Parameters
[{'name': 'automount_token', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Block All Egress Traffic

### ID
weave.policies.block-all-egress-traffic

### Description
### Block all traffic
If you are using a CNI that allows for Network Policies, you can use this Policy to block all Egress traffic between namespaces. 

By default, if no policies exist in a namespace, then all ingress and egress traffic is allowed to and from pods in that namespace. 


### How to solve?
Validate your use case and check network policies for traffic blocking. 

https://kubernetes.io/docs/concepts/services-networking/network-policies/


### Category
weave.categories.network-security

### Severity
medium

### Targets
{'kinds': ['NetworkPolicy']}

### Tags
['pci-dss', 'mitre-attack', 'nist800-190', 'gdpr', 'soc2-type1']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Part Of Label

### ID
weave.policies.missing-kubernetes-app-part-of-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Should Not Run In Namespace

### ID
weave.policies.containers-should-not-run-in-namespace

### Description
This Policy ensure workloads are not running in a specified namespace. 


### How to solve?
Use a `namespace` that differs from the one specified in the Policy. 
```
metadata:
  namespace: <custom_namespace>
```

https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['cis-benchmark', 'soc2-type1']

### Parameters
[{'name': 'custom_namespace', 'type': 'string', 'required': True, 'value': 'default'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Prohibit Environment Variable - MARIADB_ALLOW_EMPTY_PASSWORD

### ID
weave.policies.mariadb-prohibit-empty-password-env-var

### Description
This Policy ensures MARIADB_ALLOW_EMPTY_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MARIADB_ALLOW_EMPTY_PASSWORD: MARIADB_ALLOW_EMPTY_PASSWORD set to true will allow the container to be started with a blank password for the root user


### How to solve?
If you encounter a violation, ensure the MARIADB_ALLOW_EMPTY_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Services Restrict Protocols

### ID
weave.policies.services-restrict-protocols

### Description
This Policy specifies what protocols should set for your Service. Any protocol not listed in this Policy will be in violation. 


### How to solve?
Use a protocol that is specified in the Policy. 
```
spec:
  ports:
    - protocol: <protocols>
```


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Service']}

### Tags
['pci-dss', 'soc2-type1']

### Parameters
[{'name': 'protocols', 'type': 'string', 'required': True, 'value': 'HTTPS'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Running With Privilege Escalation

### ID
weave.policies.containers-running-with-privilege-escalation

### Description
Containers are running with PrivilegeEscalation configured. Setting this Policy to `true` allows child processes to gain more privileges than its parent process.  

This Policy gates whether or not a user is allowed to set the security context of a container to `allowPrivilegeEscalation` to `true`. The default value for this is `false` so no child process of a container can gain more privileges than its parent.

There are 2 parameters for this Policy:
- exclude_namespace (string) : This sets a namespace you want to exclude from Policy compliance checking. 
- allow_privilege_escalation (bool) : This checks for the value of `allowPrivilegeEscalation` in your spec.  


### How to solve?
Check the following path to see what the PrivilegeEscalation value is set to.
```
...
  spec:
    containers:
      securityContext:
        allowPrivilegeEscalation: <value>
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default', 'soc2-type1']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': True, 'value': ['kube-system']}, {'name': 'allow_privilege_escalation', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_DATABASE

### ID
weave.policies.mysql-enforce-database-env-var

### Description
This Policy ensures MYSQL_DATABASE environment variable are in place when using the official container images from Docker Hub.
MYSQL_DATABASE: The MYSQL_DATABASE environment variable sets a default MySQL database instance up with the name of that DB being the value of  environment variable. 


### How to solve?
If you encounter a violation, ensure the MYSQL_DATABASE environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Created By Label

### ID
weave.policies.missing-kubernetes-app-created-by-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_HOST_AUTH_METHOD

### ID
weave.policies.postgres-enforce-auth-method-env-var

### Description
This Policy ensures POSTGRES_HOST_AUTH_METHOD environment variable are in place when using the official container images from Docker Hub.
POSTGRES_HOST_AUTH_METHOD: The POSTGRES_HOST_AUTH_METHOD environment variable is used to control the auth-method for host connections for all databases, all users, and all addresses. If unspecified then md5 password authentication is used. 


### How to solve?
If you encounter a violation, ensure the POSTGRES_HOST_AUTH_METHOD environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_DB

### ID
weave.policies.postgres-enforce-db-env-var

### Description
This Policy ensures POSTGRES_DB environment variable are in place when using the official container images from Docker Hub.
POSTGRES_DB: The POSTGRES_DB environment variable defines a different name for the default database that is created when the image is first started. If it is not specified, then the value of POSTGRES_USER will be used.


### How to solve?
If you encounter a violation, ensure the POSTGRES_DB environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_USERNAME

### ID
weave.policies.influxdb-enforce-username-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_USERNAME environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_USERNAME: The username to set for the system's initial super-user (Required).


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_USERNAME environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_PASSWORD

### ID
weave.policies.mysql-enforce-password-env-var

### Description
This Policy ensures MYSQL_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_PASSWORD: The MYSQL_PASSWORD environment variable specifies a password for MYSQL_USER user. 


### How to solve?
If you encounter a violation, ensure the MYSQL_PASSWORD environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Sharing Host PID

### ID
weave.policies.containers-sharing-host-pid

### Description
This Policy allows check if sharing host PID namespace with the container should be allowed or not. Resources that can be shared with the container include:

### hostNetwork
Controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.

### hostPID
Controls whether the pod containers can share the host process ID namespace. Note that when paired with ptrace this can be used to escalate privileges outside of the container (ptrace is forbidden by default).

### shareProcessNamespace
When process namespace sharing is enabled, processes in a container are visible to all other containers in that pod.

### hostIPC
Controls whether the pod containers can share the host IPC namespace.


### How to solve?
Match the shared resource with either true or false, as set in your constraint. 
```
...
  spec:
    <shared_resource>: <resource_enabled>
```
https://kubernetes.io/docs/concepts/policy/pod-security-policy/#host-namespaces


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['cis-benchmark', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'resource_enabled', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_DEFAULT_VHOST

### ID
weave.policies.rabbitmq-enforce-default-vhost-env-var

### Description
This Policy ensures RABBITMQ_DEFAULT_VHOST environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_DEFAULT_VHOST: RABBITMQ_DEFAULT_VHOST sets a Virtual host to create from scratch.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_DEFAULT_VHOST environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MongoDB Enforce Environment Variable - MONGO_INITDB_ROOT_PASSWORD

### ID
weave.policies.mongodb-enforce-root-password-env-var

### Description
This Policy ensures MONGO_INITDB_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MONGO_INITDB_ROOT_PASSWORD: The MONGO_INITDB_ROOT_PASSWORD environment variable sets the MongoDB root user password.


### How to solve?
If you encounter a violation, ensure the MONGO_INITDB_ROOT_PASSWORD environment variables is set.
For futher information about the MongoDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_PASSWORD

### ID
weave.policies.postgres-enforce-password-env-var

### Description
This Policy ensures POSTGRES_PASSWORD environment variable are in place when using the official container images from Docker Hub.
POSTGRES_PASSWORD:   The POSTGRES_PASSWORD environment variable is required for you to use the PostgreSQL image. It must not be empty or undefined. This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the POSTGRES_USER environment variable.


### How to solve?
If you encounter a violation, ensure the POSTGRES_PASSWORD environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Not Using Runtime Default Seccomp Profile

### ID
weave.policies.containers-not-using-runtime-default-seccomp-profile

### Description
This Policy checks for runtime/default seccomp annotation. 

Seccomp stands for secure computing mode and has been a feature of the Linux kernel since version 2.6.12. It can be used to sandbox the privileges of a process, restricting the calls it is able to make from userspace into the kernel. Kubernetes lets you automatically apply seccomp profiles loaded onto a Node to your Pods and containers.


### How to solve?
Depending on the version of Kubernetes, you either need to set an annotation or a seccomp type in your `securityContext`. 
```
metadata:
  annotations:
    seccomp.security.alpha.kubernetes.io/pod: <seccomp_annotation>
```
AND
```
...
  spec:
    seccompProfile:
      type: <seccomp_type>
```
https://kubernetes.io/docs/tutorials/clusters/seccomp/#create-pod-that-uses-the-container-runtime-default-seccomp-profile


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['cis-benchmark', 'nist800-190', 'soc2-type1']

### Parameters
[{'name': 'seccomp_annotation', 'type': 'string', 'required': True, 'value': 'runtime/default'}, {'name': 'seccomp_type', 'type': 'string', 'required': True, 'value': 'RuntimeDefault'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MongoDB Enforce Environment Variable - MONGO_INITDB_DATABASE

### ID
weave.policies.mongodb-enforce-database-env-var

### Description
This Policy ensures MONGO_INITDB_DATABASE environment variable are in place when using the official container images from Docker Hub.
MONGO_INITDB_DATABASE: The MONGO_INITDB_DATABASE environment variable allows you to specify the name of a database to be used for creation scripts.


### How to solve?
If you encounter a violation, ensure the MONGO_INITDB_DATABASE environment variables is set.
For futher information about the MongoDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Image Pull Policy

### ID
weave.policies.container-image-pull-policy

### Description
This Policy is to ensure you are setting a value for your `imagePullPolicy`. 

The `imagePullPolicy` and the tag of the image affect when the kubelet attempts to pull the specified image.

`imagePullPolicy`: IfNotPresent: the image is pulled only if it is not already present locally.

`imagePullPolicy`: Always: every time the kubelet launches a container, the kubelet queries the container image registry to resolve the name to an image digest. If the kubelet has a container image with that exact digest cached locally, the kubelet uses its cached image; otherwise, the kubelet downloads (pulls) the image with the resolved digest, and uses that image to launch the container.

`imagePullPolicy` is omitted and either the image tag is :latest or it is omitted: `imagePullPolicy` is automatically set to Always. Note that this will not be updated to IfNotPresent if the tag changes value.

`imagePullPolicy` is omitted and the image tag is present but not :latest: `imagePullPolicy` is automatically set to IfNotPresent. Note that this will not be updated to Always if the tag is later removed or changed to :latest.

`imagePullPolicy`: Never: the image is assumed to exist locally. No attempt is made to pull the image.


### How to solve?
Ensure you have an imagePullPolicy set that matches your policy. 
```
...
  spec:
    containers:
    - imagePullPolicy: <policy>
```
https://kubernetes.io/docs/concepts/configuration/overview/#container-images


### Category
weave.categories.software-supply-chain

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'policy', 'type': 'string', 'required': True, 'value': 'Always'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_SSL_CRT_PATH

### ID
weave.policies.mongo-express-enforce-ssl-crt-path-env-var

### Description
This Policy ensures ME_CONFIG_SITE_SSL_CRT_PATH environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_SSL_CRT_PATH: The ME_CONFIG_SITE_SSL_CRT_PATH environment variable sets the SSL Certificate path. 


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_SSL_CRT_PATH environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_CACERTFILE

### ID
weave.policies.rabbitmq-enforce-ssl-ca-cert-file-env-var

### Description
This Policy ensures RABBITMQ_SSL_CACERTFILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_CACERTFILE: RABBITMQ_SSL_CACERTFILE sets a path to the CA certificate file. 


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_CACERTFILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_BASICAUTH_PASSWORD

### ID
weave.policies.mongo-express-enforce-auth-password-env-var

### Description
This Policy ensures ME_CONFIG_BASICAUTH_PASSWORD environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_BASICAUTH_PASSWORD: The ME_CONFIG_BASICAUTH_PASSWORD environment variable sets the mongo-express web password.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_BASICAUTH_PASSWORD environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_PASSWORD

### ID
weave.policies.mariadb-enforce-password-env-var

### Description
This Policy ensures MARIADB_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MARIADB_PASSWORD: The MARIADB_PASSWORD environment variable specifies a password for MARIADB_USER user.


### How to solve?
If you encounter a violation, ensure the MARIADB_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Block Ssh Port

### ID
weave.policies.containers-block-ssh-port

### Description
This Policy checks if the container is exposing ssh port.


### How to solve?
Make sure you are not exposing ssh port on containers.
```
...
  spec:
    containers:
      ports:
      - containerPort: <port>
```


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'container_port', 'type': 'integer', 'required': True, 'value': 22}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT

### ID
weave.policies.rabbitmq-enforce-fail-if-no-peer-cert-env-var

### Description
This Policy ensures RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT: RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT when set to true, TLS connection will be rejected if client fails to provide a certificate.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_FAIL_IF_NO_PEER_CERT environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_DEFAULT_PASS

### ID
weave.policies.rabbitmq-enforce-default-pass-env-var

### Description
This Policy ensures RABBITMQ_DEFAULT_PASS environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_DEFAULT_PASS: The RABBITMQ_DEFAULT_PASS environment variable sets the password for the default user.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_DEFAULT_PASS environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_SESSIONSECRET

### ID
weave.policies.mongo-express-enforce-session-secret-env-var

### Description
This Policy ensures ME_CONFIG_SITE_SESSIONSECRET environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_SESSIONSECRET: The ME_CONFIG_SITE_SESSIONSECRET environment variable is used to sign the session ID cookie by [express-session middleware](https://www.npmjs.com/package/express-session).


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_SESSIONSECRET environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_SSL_KEY_PATH

### ID
weave.policies.mongo-express-enforce-ssl-key-path-env-var

### Description
This Policy ensures ME_CONFIG_SITE_SSL_KEY_PATH environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_SSL_KEY_PATH: The ME_CONFIG_SITE_SSL_KEY_PATH environment variable sets the SSL Key file path. 


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_SSL_KEY_PATH environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_CERTFILE

### ID
weave.policies.rabbitmq-enforce-ssl-cert-file-env-var

### Description
This Policy ensures RABBITMQ_SSL_CERTFILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_CERTFILE: RABBITMQ_SSL_CERTFILE sets a path to the server certificate file. 


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_CERTFILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Component Label

### ID
weave.policies.missing-kubernetes-app-component-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Version Label

### ID
weave.policies.missing-kubernetes-app-version-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/part-of
* app.kubernetes.io/component
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Using Hostport

### ID
weave.policies.containers-using-hostport

### Description
This Policy checks if `hostPort` is set. When `hostPort` is set, a Pod is bound to a hostPort and limits the number of places the Pod can be scheduled. That's because each <hostIP, hostPort, protocol> combination must be unique. If you don't specify the hostIP and protocol explicitly, Kubernetes will use 0.0.0.0 as the default hostIP and TCP as the default protocol.

Don't specify a hostPort for a Pod unless it is absolutely necessary.  


### How to solve?
Try avoid setting `hostPort` in your spec. 
```
...
  spec:
    containers:
    - ports:
      - hostPort: 8080
```
https://kubernetes.io/docs/concepts/configuration/overview/#services


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'nist800-190']

### Parameters
[{'name': 'host_port', 'type': 'string', 'required': True, 'value': 'hostPort'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Persistent Volume Reclaim Policy Should Be Set To Retain

### ID
weave.policies.persistent-volume-reclaim-policy-should-be-set-to-retain

### Description
This Policy checks to see whether or not the persistent volume reclaim policy is set.

PersistentVolumes can have various reclaim policies, including "Retain", "Recycle", and "Delete". For dynamically provisioned PersistentVolumes, the default reclaim policy is "Delete". This means that a dynamically provisioned volume is automatically deleted when a user deletes the corresponding PersistentVolumeClaim. This automatic behavior might be inappropriate if the volume contains precious data. In that case, it is more appropriate to use the "Retain" policy. With the "Retain" policy, if a user deletes a PersistentVolumeClaim, the corresponding PersistentVolume is not be deleted. Instead, it is moved to the Released phase, where all of its data can be manually recovered.


### How to solve?
Check your reclaim policy configuration within your PersistentVolume configuration. 
```
spec:
  persistentVolumeReclaimPolicy: <pv_policy>
```

https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/#why-change-reclaim-policy-of-a-persistentvolume


### Category
weave.categories.data-protection

### Severity
medium

### Targets
{'kinds': ['PersistentVolume']}

### Tags
['pci-dss', 'soc2-type1']

### Parameters
[{'name': 'pv_policy', 'type': 'string', 'required': True, 'value': 'Retain'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_DATABASE

### ID
weave.policies.mariadb-enforce-database-env-var

### Description
This Policy ensures MARIADB_DATABASE environment variable are in place when using the official container images from Docker Hub.
MARIADB_DATABASE:   The MARIADB_DATABASE environment variable sets a default MARIADB database instance up with the name of that DB being the value of  environment variable. 


### How to solve?
If you encounter a violation, ensure the MARIADB_DATABASE environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Instance Label

### ID
weave.policies.missing-kubernetes-app-instance-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Should Not Run On Kubernetes Control Plane Nodes

### ID
weave.policies.containers-should-not-run-on-kubernetes-control-plane-nodes

### Description
Tolerations specified in the Policies for this template should not have any workloads scheduled on them. A common use case is the Kubernetes master. 


### How to solve?
Check your tolerations against the Policy. 
```
...
  spec:
    tolerations:
    - key: <toleration_key>
```

https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/


### Category
weave.categories.capacity-management

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['soc2-type1']

### Parameters
[{'name': 'toleration_key', 'type': 'string', 'required': True, 'value': 'node-role.kubernetes.io/master'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_ENABLED_PLUGINS_FILE

### ID
weave.policies.rabbitmq-enforce-enabled-plugins-env-var

### Description
This Policy ensures RABBITMQ_ENABLED_PLUGINS_FILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_ENABLED_PLUGINS_FILE: This file records explicitly enabled plugins. When a plugin is enabled or disabled, this file will be recreated. It is important that effective RabbitMQ user has sufficient permissions to read, write and create this file at any time.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_ENABLED_PLUGINS_FILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_MONGODB_ENABLE_ADMIN

### ID
weave.policies.mongo-express-enforce-enable-admin-env-var

### Description
This Policy ensures ME_CONFIG_MONGODB_ENABLE_ADMIN environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_MONGODB_ENABLE_ADMIN: The ME_CONFIG_MONGODB_ENABLE_ADMIN environment variable enables admin access to all databases. Send strings: `"true"` or `"false"`


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_MONGODB_ENABLE_ADMIN environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Owner Label

### ID
weave.policies.missing-owner-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_ONETIME_PASSWORD

### ID
weave.policies.mysql-enforce-onetime-password-env-var

### Description
This Policy ensures MYSQL_ONETIME_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_ONETIME_PASSWORD: The MYSQL_ONETIME_PASSWORD environment variable is set, the root user's password is set as expired and must be changed before MySQL can be used normally 


### How to solve?
If you encounter a violation, ensure the MYSQL_ONETIME_PASSWORD environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SCHEMA_DIR

### ID
weave.policies.rabbitmq-enforce-schema-dir-env-var

### Description
This Policy ensures RABBITMQ_SCHEMA_DIR environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SCHEMA_DIR: The directory where RabbitMQ keeps its configuration schema used by the new style configuration file.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SCHEMA_DIR environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_INITDB_ARGS

### ID
weave.policies.postgres-enforce-initdb-args-env-var

### Description
This Policy ensures POSTGRES_INITDB_ARGS environment variable are in place when using the official container images from Docker Hub.
POSTGRES_INITDB_ARGS:   The POSTGRES_INITDB_ARGS environment variable is used to send arguments to postgres initdb. The value is a space separated string of arguments as postgres initdb would expect them. This is useful for adding functionality like data page checksums: `-e POSTGRES_INITDB_ARGS="--data-checksums"`.


### How to solve?
If you encounter a violation, ensure the POSTGRES_INITDB_ARGS environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_BUCKET

### ID
weave.policies.influxdb-enforce-bucket-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_BUCKET environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_BUCKET: The name to set for the system's initial bucket (Required).


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_BUCKET environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Running As User

### ID
weave.policies.container-running-as-user

### Description
Containers has a feature in which you specify the ID of the user which all processes in the container will run with. This Policy enforces that the `securityContext.runAsUser` attribute is set to a uid greater than root uid. Running as root user gives the container full access to all resources in the VM it is running on. Containers should not run with such access rights unless required by design. 


### How to solve?
You should set `securityContext.runAsUser` uid to something greater than root uid. Not setting it will default to giving the container root user rights on the VM that it is running on. 
```
...
  spec:
    securityContext:
      runAsUser: <uid>
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'uid', 'type': 'integer', 'required': True, 'value': 0}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': ['kube-system']}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Missing Readiness Probe

### ID
weave.policies.containers-missing-readiness-probe

### Description
This Policy detects whether or not a readinessProbe has been set for containers. Containers probes are:

### liveness 
The kubelet uses liveness probes to know when to restart a container. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs.

### readiness
The kubelet uses readiness probes to know when a container is ready to start accepting traffic. A Pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for Services. When a Pod is not ready, it is removed from Service load balancers.

### startup
The kubelet uses startup probes to know when a container application has started. If such a probe is configured, it disables liveness and readiness checks until it succeeds, making sure those probes don't interfere with the application startup. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.


### How to solve?
Check your entities to see if a probe has been set. 
```
...
  spec:
    containers:
    - readinessProbe:
      ...
```
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/


### Category
weave.categories.reliability

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Block Ports Range

### ID
weave.policies.containers-block-ports-range

### Description
This Policy checks for container ports that are set below the set value. TCP ports under 1024 are reserved so we recommend setting your Policy to 1024 or higher. 


### How to solve?
Choose ports over the value that is specified in the Policy. 
```
...
  spec:
    containers:
      - ports:
        - containerPort: <target_port>
```
https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'nist800-190']

### Parameters
[{'name': 'target_port', 'type': 'integer', 'required': True, 'value': 1024}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS

### ID
weave.policies.rabbitmq-enforce-additional-erl-args-env-var

### Description
This Policy ensures RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS: The RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS environment variable sets additional parameters for the erl command used when invoking the RabbitMQ Server. The value of this variable is appended to the default list of arguments (RABBITMQ_SERVER_ERL_ARGS).


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_ROOT_PASSWORD

### ID
weave.policies.mariadb-enforce-root-password-env-var

### Description
This Policy ensures MARIADB_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MARIADB_ROOT_PASSWORD: The MARIADB_ROOT_PASSWORD environment variable specifies a password for the MARIADB root account. 


### How to solve?
If you encounter a violation, ensure the MARIADB_ROOT_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Sharing Host Network

### ID
weave.policies.containers-sharing-host-network

### Description
This Policy allows check if sharing host network namespace with the container should be allowed or not. Resources that can be shared with the container include:

### hostNetwork
Controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.

### hostPID
Controls whether the pod containers can share the host process ID namespace. Note that when paired with ptrace this can be used to escalate privileges outside of the container (ptrace is forbidden by default).

### shareProcessNamespace
When process namespace sharing is enabled, processes in a container are visible to all other containers in that pod.

### hostIPC
Controls whether the pod containers can share the host IPC namespace.


### How to solve?
Match the shared resource with either true or false, as set in your constraint. 
```
...
  spec:
    <shared_resource>: <resource_enabled>
```
https://kubernetes.io/docs/concepts/policy/pod-security-policy/#host-namespaces


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['cis-benchmark', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'resource_enabled', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_MONGODB_PORT

### ID
weave.policies.mongo-express-enforce-mongodb-port-env-var

### Description
This Policy ensures ME_CONFIG_MONGODB_PORT environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_MONGODB_PORT: The ME_CONFIG_MONGODB_PORT environment variable sets the mongodb port


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_MONGODB_PORT environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Missing Startup Probe

### ID
weave.policies.containers-missing-startup-probe

### Description
This Policy detects whether or not a startupProbe has been set for containers. Containers probes are:

### liveness 
The kubelet uses liveness probes to know when to restart a container. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs.

### readiness
The kubelet uses readiness probes to know when a container is ready to start accepting traffic. A Pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for Services. When a Pod is not ready, it is removed from Service load balancers.

### startup
The kubelet uses startup probes to know when a container application has started. If such a probe is configured, it disables liveness and readiness checks until it succeeds, making sure those probes don't interfere with the application startup. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.


### How to solve?
Check your entities to see if a probe has been set. 
```
...
  spec:
    containers:
    - startupProbe:
      ...
```
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/


### Category
weave.categories.reliability

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_MNESIA_DIR

### ID
weave.policies.rabbitmq-enforce-mnesia-dir-env-var

### Description
This Policy ensures RABBITMQ_MNESIA_DIR environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_MNESIA_DIR: The directory where this RabbitMQ node's data is stored. This s a schema database, message stores, cluster member information and other persistent node state.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_MNESIA_DIR environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_RANDOM_ROOT_PASSWORD

### ID
weave.policies.mysql-enforce-random-root-password-env-var

### Description
This Policy ensures MYSQL_RANDOM_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_RANDOM_ROOT_PASSWORD: The MYSQL_RANDOM_ROOT_PASSWORD environment variable creates random password for the server's root user when the Docker container is started.


### How to solve?
If you encounter a violation, ensure the MYSQL_RANDOM_ROOT_PASSWORD environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_PLUGINS_DIR

### ID
weave.policies.rabbitmq-enforce-plugins-dir-env-var

### Description
This Policy ensures RABBITMQ_PLUGINS_DIR environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_PLUGINS_DIR: The list of directories where plugin archive files are located and extracted from. This is PATH-like variable, where different paths are separated by an OS-specific separator (: for Unix, ; for Windows). Plugins can be installed to any of the directories listed here.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_PLUGINS_DIR environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_ADMIN_TOKEN

### ID
weave.policies.influxdb-enforce-admin-token-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_ADMIN_TOKEN environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_ADMIN_TOKEN: The authentication token to associate with the system's initial super-user. If not set, a token will be auto-generated by the system.


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_ADMIN_TOKEN environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_COOKIESECRET

### ID
weave.policies.mongo-express-enforce-cookie-secret-env-var

### Description
This Policy ensures ME_CONFIG_SITE_COOKIESECRET environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_COOKIESECRET: The ME_CONFIG_SITE_COOKIESECRET environment variable is used by [cookie-parser middleware](https://www.npmjs.com/package/cookie-parser) to sign cookies.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_COOKIESECRET environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Enforce Restart Policy

### ID
weave.policies.containers-enforce-restart-policy

### Description
This Policy checks if a specific restartPolicy is configured in your workloads.


### How to solve?
Ensure the restartPolicy is set to some specific policy in your workloads. 
```
...
  spec:
    restartPolicy: <policy>
```


### Category
weave.categories.organizational-standards

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'restart_policy', 'type': 'string', 'required': True, 'value': 'Always'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_SSL_VERIFY

### ID
weave.policies.rabbitmq-enforce-ssl-verify-env-var

### Description
This Policy ensures RABBITMQ_SSL_VERIFY environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_SSL_VERIFY: The RABBITMQ_SSL_VERIFY enables peer verification. 


### How to solve?
If you encounter a violation, ensure the RABBITMQ_SSL_VERIFY environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MARIADB_USER

### ID
weave.policies.mariadb-enforce-user-env-var

### Description
This Policy ensures MARIADB_USER environment variable are in place when using the official container images from Docker Hub.
MARIADB_USER: The MARIADB_USER environment variable sets up a superuser with the same name.


### How to solve?
If you encounter a violation, ensure the MARIADB_USER environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Prohibit Environment Variable - MYSQL_ALLOW_EMPTY_PASSWORD

### ID
weave.policies.mariadb-prohibit-mysql-empty-password-env-var

### Description
This Policy ensures MYSQL_ALLOW_EMPTY_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_ALLOW_EMPTY_PASSWORD: MYSQL_ALLOW_EMPTY_PASSWORD set to true will allow the container to be started with a blank password for the root user


### How to solve?
If you encounter a violation, ensure the MYSQL_ALLOW_EMPTY_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Using Hostpath

### ID
weave.policies.containers-using-hostpath

### Description
This Policy checks for containers that are trying to use HostPath. 

A `hostPath` volume mounts a file or directory from the host node's filesystem into your Pod. This is not something that most Pods will need, but it offers a powerful escape hatch for some applications.


### How to solve?
Using HostPath could allow mounting the entire host’s filesystem into your pod, giving you read/write access on the host’s filesystem. This leaves your cluster vulnerable to escape Kubernetes constraints and access components at the Node (OS) level. 
```
...
  spec:
    template:
      spec:
        volumes:
          - hostPath:
```


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'hostpath_key', 'type': 'string', 'required': True, 'value': 'hostPath'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_INITDB_SKIP_TZINFO

### ID
weave.policies.mysql-enforce-skip-tzinfo-env-var

### Description
This Policy ensures MYSQL_INITDB_SKIP_TZINFO environment variable are in place when using the official container images from Docker Hub.
MYSQL_INITDB_SKIP_TZINFO: The MYSQL_INITDB_SKIP_TZINFO environment variable allows the skipping of timezone checking when initializing the DB.


### How to solve?
If you encounter a violation, ensure the MYSQL_INITDB_SKIP_TZINFO environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Prometheus Rbac Prohibit Verbs

### ID
weave.policies.prometheus-rbac-prohibit-verbs

### Description
This Policy blocks certain verbs from being set for Prometheus RBAC. This Policy applies to RBAC names containing the word `prometheus`. 


### How to solve?
Check the `rules.verbs` for the verb(s) list and check the policy to see what value is set. 
```
metadata:
  name: prometheus
...
rules:
  - verbs:
      - <prometheus_verb>
```

https://kubernetes.io/docs/reference/access-authn-authz/rbac/


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['ClusterRole']}

### Tags
['pci-dss', 'hipaa', 'soc2-type1']

### Parameters
[{'name': 'prometheus_verb', 'type': 'string', 'required': True, 'value': 'put'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Running With Unapproved Linux Capabilities

### ID
weave.policies.containers-running-with-unapproved-linux-capabilities

### Description
Linux capabilities provide a finer-grained breakdown of the privileges traditionally associated with the superuser. Not specifying those capabilities gives the container access to all OS capabilities which may result in exploiting the VM at which the container is running. The issue is reported when a container has `SYS_ADMIN`, `NET_RAW`, `NET_ADMIN`, or `ALL` capabilities. For this Policy, you can also exclude a namespace, such as `kube-system`. 

With Linux capabilities, you can grant certain privileges to a process without granting all the privileges of the root user. To add or remove Linux capabilities for a Container, include the capabilities field in the securityContext section of the Container manifest.


### How to solve?
You should set the specific Linux capabilities that your container needs. Or you could simply remove from `capabilities` the values of `SYS_ADMIN`, `NET_ADMIN`, and `ALL`.
```
...
  spec:
    containers:
    - securityContext:
        capabilities:
          add: ["SYS_ADMIN, "ALL", "NET_ADMIN"]
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'soc2-type1', 'default']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}]

---

## Rbac Protect Cluster Admin Clusterrolebindings

### ID
weave.policies.rbac-protect-cluster-admin-clusterrolebindings

### Description
This Policy allows you to select which groups you can set for Cluster-admin. The default policy checks for the 

```
subjects:
- kind: Group
  name: system:masters
```

`cluster-admin` allows super-user access to perform any action on any resource. When used in a ClusterRoleBinding, it gives full control over every resource in the cluster and in all namespaces. When used in a RoleBinding, it gives full control over every resource in the role binding's namespace, including the namespace itself. Be selective when adding additional subjects. 


### How to solve?
Remove any kinds and names that are not consistent with the constraint. 
```
kind: ClusterRoleBinding
metadata:
  name: cluster-admin
...
subjects:
- kind: Group
  name: system:masters
```  
https://kubernetes.io/docs/reference/access-authn-authz/rbac/


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['ClusterRoleBinding']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'gdpr', 'hipaa', 'soc2-type1']

### Parameters
[{'name': 'subjects_name', 'type': 'string', 'required': True, 'value': 'system:masters'}, {'name': 'subjects_kind', 'type': 'string', 'required': True, 'value': 'Group'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_DEFAULT_USER

### ID
weave.policies.rabbitmq-enforce-default-user-env-var

### Description
This Policy ensures RABBITMQ_DEFAULT_USER environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_DEFAULT_USER: The RABBITMQ_DEFAULT_USER environment variable sets the User name to create when RabbitMQ creates a new database from scratch.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_DEFAULT_USER environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MariaDB Enforce Environment Variable - MYSQL_PASSWORD

### ID
weave.policies.mariadb-enforce-mysql-password-env-var

### Description
This Policy ensures MYSQL_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_PASSWORD: The MYSQL_PASSWORD environment variable specifies a password for MARIADB_USER user.


### How to solve?
If you encounter a violation, ensure the MYSQL_PASSWORD environment variables is set.
For futher information about the MariaDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Prohibit Image Tag

### ID
weave.policies.container-prohibit-image-tag

### Description
Prohibit certain image tags by specifying them in the Policy. The Policy will also violate if the a tag is not set, or is set to `latest`. 

Note: You should avoid using the :latest tag when deploying containers in production as it is harder to track which version of the image is running and more difficult to roll back properly.


### How to solve?
Configure an image tag that is not in the Policy. 
```
...
  spec:
    containers:
    - image: registry/image_name:<tag>
```
https://kubernetes.io/docs/concepts/configuration/overview/#container-images


### Category
weave.categories.software-supply-chain

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['cis-benchmark', 'mitre-attack', 'gdpr', 'soc2-type1', 'default']

### Parameters
[{'name': 'image_tag', 'type': 'string', 'required': True, 'value': 'latest'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_ROOT_PASSWORD

### ID
weave.policies.mysql-enforce-root-password-env-var

### Description
This Policy ensures MYSQL_ROOT_PASSWORD environment variable are in place when using the official container images from Docker Hub.
MYSQL_ROOT_PASSWORD: The MYSQL_ROOT_PASSWORD environment variable specifies a password for the MySQL root account. 


### How to solve?
If you encounter a violation, ensure the MYSQL_ROOT_PASSWORD environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Postgres Enforce Environment Variable - POSTGRES_USER

### ID
weave.policies.postgres-enforce-user-env-var

### Description
This Policy ensures POSTGRES_USER environment variable are in place when using the official container images from Docker Hub.
POSTGRES_USER: The POSTGRES_USER environment variable is used in conjunction with POSTGRES_PASSWORD to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of postgres will be used.
Be aware that if this parameter is specified, PostgreSQL will still show The files belonging to this database system will be owned by user "postgres" during initialization. This refers to the Linux system user (from /etc/passwd in the image) that the postgres daemon runs as, and as such is unrelated to the POSTGRES_USER option. See the section titled "Arbitrary --user Notes" for more details.


### How to solve?
If you encounter a violation, ensure the POSTGRES_USER environment variables is set.
For futher information about the Postgres Docker container, check here: https://hub.docker.com/_/postgres


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_CONFIG_FILE

### ID
weave.policies.rabbitmq-enforce-config-file-env-var

### Description
This Policy ensures RABBITMQ_CONFIG_FILE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_CONFIG_FILE: The path to the configuration file, without the .config extension. If the configuration file is present it is used by the server to configure RabbitMQ components. See Configuration guide for more information.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_CONFIG_FILE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MongoDB Enforce Environment Variable - MONGO_INITDB_ROOT_USERNAME

### ID
weave.policies.mongodb-enforce-root-username-env-var

### Description
This Policy ensures MONGO_INITDB_ROOT_USERNAME environment variable are in place when using the official container images from Docker Hub.
MONGO_INITDB_ROOT_USERNAME: The MONGO_INITDB_ROOT_USERNAME environment variable sets the MongoDB root user name.


### How to solve?
If you encounter a violation, ensure the MONGO_INITDB_ROOT_USERNAME environment variables is set.
For futher information about the MongoDB Docker container, check here: https://hub.docker.com/_/mariadb


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Managed By Label

### ID
weave.policies.missing-kubernetes-app-managed-by-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource	


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_SITE_SSL_ENABLED

### ID
weave.policies.mongo-express-enforce-ssl-enabled-env-var

### Description
This Policy ensures ME_CONFIG_SITE_SSL_ENABLED environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_SITE_SSL_ENABLED: The ME_CONFIG_SITE_SSL_ENABLED environment variable enables SSL.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_SITE_SSL_ENABLED environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.network-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_LOGS

### ID
weave.policies.rabbitmq-enforce-logs-env-var

### Description
This Policy ensures RABBITMQ_LOGS environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_LOGS: The path of the RabbitMQ server's Erlang log file. This variable cannot be overridden on Windows.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_LOGS environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_LOG_BASE

### ID
weave.policies.rabbitmq-enforce-log-base-env-var

### Description
This Policy ensures RABBITMQ_LOG_BASE environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_LOG_BASE: This base directory contains the RabbitMQ server's log files, unless RABBITMQ_LOGS is set.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_LOG_BASE environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_MONGODB_ADMINPASSWORD

### ID
weave.policies.mongo-express-enforce-admin-password-env-var

### Description
This Policy ensures ME_CONFIG_MONGODB_ADMINPASSWORD environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_MONGODB_ADMINPASSWORD: The ME_CONFIG_MONGODB_ADMINPASSWORD environment variable sets the MongoDB admin password.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_MONGODB_ADMINPASSWORD environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Running As Root

### ID
weave.policies.container-running-as-root

### Description
Running as root gives the container full access to all resources in the VM it is running on. Containers should not run with such access rights unless required by design. This Policy enforces that the `securityContext.runAsNonRoot` attribute is set to `true`. 


### How to solve?
You should set `securityContext.runAsNonRoot` to `true`. Not setting it will default to giving the container root user rights on the VM that it is running on. 
```
...
  spec:
    securityContext:
      runAsNonRoot: true
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': ['kube-system']}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Block All Ingress Traffic

### ID
weave.policies.block-all-ingress-traffic

### Description
### Block all traffic
If you are using a CNI that allows for Network Policies, you can use this Policy to block all Ingress traffic between namespaces. 

By default, if no policies exist in a namespace, then all ingress and egress traffic is allowed to and from pods in that namespace. 


### How to solve?
Validate your use case and check network policies for traffic blocking. 

https://kubernetes.io/docs/concepts/services-networking/network-policies/


### Category
weave.categories.network-security

### Severity
medium

### Targets
{'kinds': ['NetworkPolicy']}

### Tags
['pci-dss', 'mitre-attack', 'nist800-190', 'gdpr', 'soc2-type1']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## RabbitMQ Enforce Environment Variable - RABBITMQ_GENERATED_CONFIG_DIR

### ID
weave.policies.rabbitmq-enforce-generated-config-dir-env-var

### Description
This Policy ensures RABBITMQ_GENERATED_CONFIG_DIR environment variable are in place when using the official container images from Docker Hub.
RABBITMQ_GENERATED_CONFIG_DIR: The directory where RabbitMQ writes its generated configuration files.


### How to solve?
If you encounter a violation, ensure the RABBITMQ_GENERATED_CONFIG_DIR environment variables is set.
For futher information about the RabbitMQ Docker container, check here: https://hub.docker.com/_/rabbitmq


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Disable ServiceAccount Token Automount In Specific Namespace

### ID
weave.policies.disable-service-account-token-automount-in-specific-namespace

### Description
This Policy allows you to enforce the enabling or disabling the automounting of service account tokens. 

When a pod is created without a service account defined, the default service account within the same namespace will be assigned automatically. 

This is a security concern because a kubernetes client can load a container's service account token. With that token a compromoised contaienr can then access the Kubernetes API to perform actions such as creating and deleting pods.

In version 1.6+, you can opt out of automounting API credentials for a service account by setting automountServiceAccountToken: false on the service account.


### How to solve?
Add the key:value pair `automountServiceAccountToken: false` to your Service Account declaration. 
```
kind: ServiceAccount
automountServiceAccountToken: false
```

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['ServiceAccount']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'hipaa', 'gdpr', 'default', 'soc2-type1']

### Parameters
[{'name': 'automount', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'namespace', 'type': 'string', 'required': True, 'value': 'default'}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_REQUEST_SIZE

### ID
weave.policies.mongo-express-enforce-request-size-env-var

### Description
This Policy ensures ME_CONFIG_REQUEST_SIZE environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_REQUEST_SIZE: The ME_CONFIG_REQUEST_SIZE environment variable sets the maximum payload size. CRUD operations above this size will fail in [body-parser](https://www.npmjs.com/package/body-parser).


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_REQUEST_SIZE environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Prohibit Naked Pods From Being Scheduled

### ID
weave.policies.prohibit-naked-pods-from-being-scheduled

### Description
This Policy checks for a `kind` and can prohibit it from being schedule to your cluster. A common example is running "naked" pods. 


### How to solve?
Ensure you are not using a kind that is specified within the Policy.
```
kind: <kind>
```

https://kubernetes.io/docs/concepts/configuration/overview/#naked-pods-vs-replicasets-deployments-and-jobs


### Category
weave.categories.organizational-standards

### Severity
medium

### Targets
{'kinds': ['Pod']}

### Tags
['cis-benchmark']

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_MONGODB_SERVER

### ID
weave.policies.mongo-express-enforce-mongodb-server-env-var

### Description
This Policy ensures ME_CONFIG_MONGODB_SERVER environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_MONGODB_SERVER: The ME_CONFIG_MONGODB_SERVER environment variable sets the MongoDB container name. Use comma delimited list of host names for replica sets.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_MONGODB_SERVER environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## InfluxDB Enforce Environment Variable - DOCKER_INFLUXDB_INIT_RETENTION

### ID
weave.policies.influxdb-enforce-retention-env-var

### Description
This Policy ensures DOCKER_INFLUXDB_INIT_RETENTION environment variable are in place when using the official container images from Docker Hub.
DOCKER_INFLUXDB_INIT_RETENTION: The duration the system's initial bucket should retain data. If not set, the initial bucket will retain data forever.


### How to solve?
If you encounter a violation, ensure the DOCKER_INFLUXDB_INIT_RETENTION environment variables is set.
For futher information about the InfluxDB Docker container, check here: https://hub.docker.com/_/influxdb


### Category
weave.categories.organizational-standards

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Sharing Process Namespace

### ID
weave.policies.containers-sharing-process-namespace

### Description
This Policy allows check if sharing process namespace with other containers in the pod should be allowed or not. Resources that can be shared with the container include:

### hostNetwork
Controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.

### hostPID
Controls whether the pod containers can share the host process ID namespace. Note that when paired with ptrace this can be used to escalate privileges outside of the container (ptrace is forbidden by default).

### shareProcessNamespace
When process namespace sharing is enabled, processes in a container are visible to all other containers in that pod.

### hostIPC
Controls whether the pod containers can share the host IPC namespace.


### How to solve?
Match the shared resource with either true or false, as set in your constraint. 
```
...
  spec:
    <shared_resource>: <resource_enabled>
```
https://kubernetes.io/docs/concepts/policy/pod-security-policy/#host-namespaces


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'resource_enabled', 'type': 'boolean', 'required': True, 'value': False}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Container Block Sysctls

### ID
weave.policies.container-block-sysctl

### Description
Setting sysctls can allow containers unauthorized escalated privileges to a Kubernetes node. 


### How to solve?
You should not set  `securityContext.sysctls` 
```
...
  spec:
    securityContext:
      sysctls
```
https://kubernetes.io/docs/tasks/configure-pod-container/security-context/


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'cis-benchmark', 'mitre-attack', 'nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': ['kube-system']}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Missing Kubernetes App Label

### ID
weave.policies.missing-kubernetes-app-label

### Description
Custom labels can help enforce organizational standards for each artifact deployed. This Policy ensure a custom label key is set in the entity's `metadata`. The Policy detects the presence of the following: 

### owner
A label key of `owner` will help identify who the owner of this entity is. 

### app.kubernetes.io/name
The name of the application	

### app.kubernetes.io/instance
A unique name identifying the instance of an application	  

### app.kubernetes.io/version
The current version of the application (e.g., a semantic version, revision hash, etc.)

### app.kubernetes.io/part-of
The name of a higher level application this one is part of	

### app.kubernetes.io/managed-by
The tool being used to manage the operation of an application	

### app.kubernetes.io/created-by
The controller/user who created this resource


### How to solve?
Add these custom labels to `metadata`.
* owner
* app.kubernetes.io/name
* app.kubernetes.io/instance
* app.kubernetes.io/version
* app.kubernetes.io/name
* app.kubernetes.io/part-of
* app.kubernetes.io/managed-by
* app.kubernetes.io/created-by

```
metadata:
  labels:
    <label>: value
```  
For additional information, please check
* https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels 


### Category
weave.categories.organizational-standards

### Severity
low

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## MYSQL Enforce Environment Variable - MYSQL_USER

### ID
weave.policies.mysql-enforce-user-env-var

### Description
This Policy ensures MYSQL_USER environment variable are in place when using the official container images from Docker Hub.
MYSQL_USER: The MYSQL_USER environment variable sets up a superuser with the same name. 


### How to solve?
If you encounter a violation, ensure the MYSQL_USER environment variables is set.
For futher information about the MYSQL Docker container, check here: https://hub.docker.com/_/mysql


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa', 'gdpr']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Mounting Docker Socket

### ID
weave.policies.containers-mounting-docker-socket

### Description
This Policy checks the mounting of the `docker.sock` socket of the node into the container. The docker socket filename can be altered based on your configuration. The full path is unnecessary as the Policy accounts for any path.  


### How to solve?
Ensure workloads aren't mounting the `docker.sock` (or other configured socket name) in order to avoid a violation. 
```
...
  spec:
    template:
      spec:
        volumes:
          - name: docker-sock
            hostPath:
              path: "<path>/<this value>"
              type: File
```


### Category
weave.categories.pod-security

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['nist800-190', 'gdpr', 'default']

### Parameters
[{'name': 'docker_sock', 'type': 'string', 'required': True, 'value': 'docker.sock'}, {'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Mongo-Express Enforce Environment Variable - ME_CONFIG_BASICAUTH_USERNAME

### ID
weave.policies.mongo-express-enforce-auth-username-env-var

### Description
This Policy ensures ME_CONFIG_BASICAUTH_USERNAME environment variable are in place when using the official container images from Docker Hub.
ME_CONFIG_BASICAUTH_USERNAME: The ME_CONFIG_BASICAUTH_USERNAME environment variable sets the mongo-express web username.


### How to solve?
If you encounter a violation, ensure the ME_CONFIG_BASICAUTH_USERNAME environment variables is set.
For futher information about the Mongo-Express Docker container, check here: https://hub.docker.com/_/mongo-express


### Category
weave.categories.access-control

### Severity
high

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
['pci-dss', 'mitre-attack', 'hipaa']

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

## Containers Missing Liveness Probe

### ID
weave.policies.containers-missing-liveness-probe

### Description
This Policy detects whether or not a livenessProbe has been set for containers. Containers probes are:

### liveness 
The kubelet uses liveness probes to know when to restart a container. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs.

### readiness
The kubelet uses readiness probes to know when a container is ready to start accepting traffic. A Pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for Services. When a Pod is not ready, it is removed from Service load balancers.

### startup
The kubelet uses startup probes to know when a container application has started. If such a probe is configured, it disables liveness and readiness checks until it succeeds, making sure those probes don't interfere with the application startup. This can be used to adopt liveness checks on slow starting containers, avoiding them getting killed by the kubelet before they are up and running.


### How to solve?
Check your entities to see if a probe has been set. 
```
...
  spec:
    containers:
    - livenessProbe:
      ...
```
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/


### Category
weave.categories.reliability

### Severity
medium

### Targets
{'kinds': ['Deployment', 'Job', 'ReplicationController', 'ReplicaSet', 'DaemonSet', 'StatefulSet', 'CronJob']}

### Tags
[]

### Parameters
[{'name': 'exclude_namespaces', 'type': 'array', 'required': False, 'value': None}, {'name': 'exclude_label_key', 'type': 'string', 'required': False, 'value': None}, {'name': 'exclude_label_value', 'type': 'string', 'required': False, 'value': None}]

---

