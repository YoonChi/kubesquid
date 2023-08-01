
# CKAD 3rd Edition

## (Ch. 5) Pods

### Naked Pods
Helpful commands:
- `kubectl describe pod myfirstnginx | less`
- `kubectl explain pod` or `kubectl explain pod.spec | less` or `kubectl explain --recursive pod.spec | less`

### Generating YAML files and configuring multi-container pods
- `kubectl run multicontainer --image=busybox --dry-run=client -o yaml > _multicontainer.yaml` # this creates the yaml file
- `kubectl create -f multicontainer.yaml` # this creates the pod

**Use cases for multi-container pods**
- Sidecar container: enhances the primary application, for example for logging, monitoring, and syncing. makes sense in scenarios where having the containers separated in different pods makes no sense.
  - Example: istio service mesh is used to monitor traffic in Kubernetes environment. In order to do so, it needs to fetch traffic statistics about the applications. istio service mesh injects sidecar containers in Pods, and the sidecar is just telling istio hey this what the application is doing. 

### Create a sidecar container
- `kubectl create -f sidecar.yaml`

- `kubectl exec -it sidecar-pod -c sidecar /bin/bash`
  - `exec` # run a command 
  - `-it`  # in an interactive terminal
- Once you're in the webserver, or the sidecar container, run `yum install -y curl`
- Run `curl http://localhost/date.txt` to view the file.

### Init Containers
- An init container is an additional container in a Pod that completes a task before the "regular" container is started.
- If the init container has not run to completion, the main container will not start. 

### Namespaces
- `kubectl create ns secret` # creates namespace, "secret"
- `kubectl run secretnginx --image=nginx -n secret` # run an nginx web server as a Pod using the name, secretnginx, in namespace "secret"


### Lab (Ch. 5)
1. Create a namespace with the name production and output it to YAML file
2. In production namespace, run an nginx web server as a Pod using the name nginx-prod 
   
- `kubectl create ns -h | less` 
  - `-h` is flag used to request help or get usage info for the specified command

- `kubectl create ns production --dry-run=client -o yaml > lesson5lab.yaml` # this only adds the configuration to the yaml file, it does not apply

- `kubectl run nginx-prod --image=nginx -n production --dry-run=client -o yaml >> lesson5lab.yaml` # this appends the configuration for the nginx web server pod to the existing file.

- `kubectl create -f lesson5lab.yaml` # apply and create namespace and pod


## (Ch. 6) Advanced Pod Management for Troubleshooting

### Connecting to a Pod**
- `kubectl exec -it <pod_name> -- sh` # this allows you to connect to it and run commands on the primary container in a Pod. `-- sh` allows you to open up a shell inside the pod. Type `exit` to disconnect from the shell. 
- etcd stores everything in json format. 
  - `kubectl get pods multicontainer -o json | less` 
    - `-o json` will show how the pod is stored in the etcd database
  - `kubectl get pods multicontainer -o yaml | less` # much more readable than json
    - in yaml output also shows pod's status
    - `kubectl get pods multicontainer -o json | less`


**If you want to know what a certain field from the yaml does..**

  - `kubectl explain pods.spec.enableServiceLinks`
  - ![image](pods/images/explain-field.png)

Once you've shelled into the pod..you can run these cmds to find more info about the pod:
`ps aux` or `ip a` or `mount`

**To find out more about the processes running in the pod:**
`cd /proc` . `/proc` is a filesystem, and if you `ls`, you can see  everything that this container is currently doing. the leftmost column contains the PIDs. every process running within this namespace environment has its own PID, and the PID is the entry point command used to start this container. if you want to know what's going on, just run `cat 1/cmdline`
![image](pods/images/pids.png)


### Pod logs for application troubleshooting
- Application output it sent to Kubernetes cluster
- Use `kubectl logs` to connect to the Application output


**Error Meanings:**
- `CrashLoopBackOff`: means application could not be started for some reason
- `Last State:` field indicates the last state of the Pod, and provides the Exit Code. If the Exit Code is a `0`, then the application is working. If it is any other number, use `kubectl logs` to dig further.
![image](pods/images/pod-error.png)
![image](pods/images/mydb-logs.png)
To re-create the pod, this time with the environment variables, delete mydb pod, run `kubectl run --help | less`. You'll find an example command that shows you how to include the environment variables in the kubectl commands.

**Example:** Start a hazelcast pod and set environment variables "DNS_DOMAIN=cluster" and "POD_NAMESPACE=default" in the container
`kubectl run hazelcast --image=hazelcast/hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"`
`kubectl run mydb --image=mariadb --env MYSQL_ROOT_PASSWORD=password`


**Port Forwarding**
- one way to access the Pod (troubleshooting only!)
- exposes a specific port on a running Pod from the kubectl host (your local computer)
- used for testing Pod accessibility on a specific cluster node (only)
- Kubernetes sets up a proxy between local machine and the pod, and it redirects traffic from a specified port on your local machine to a porton the pod, establishing a communication channel. 
- It is the `kubectl` command that sends a request to the API server, which establishes that connection
- syntax: `kubectl port-forward <pod-name> <local-port>:<pod-port>`
In your terminal:
`kubectl get pods -o wide`
`kubectl run fwnginx --image=nginx`
`kubectl port-forward fwnginx 8080:80` 
`curl localhost:8000`


Regular user access to apps is done through services and ingress.
