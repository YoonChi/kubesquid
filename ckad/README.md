
# CKAD 3rd Edition

## (Ch. 5)

### Naked Pods
Helpful commands:
- `kubectl describe pod myfirstnginx | less`
- `kubectl explain pod` or `kubectl explain pod.spec | less` or `kubectl explain --recursive pod.spec | less`

### Generating YAML files and configuring multi-container pods
- `kubectl run multicontainer --image=busybox -o yaml --dry-run=client -o yaml > _multicontainer.yaml` # this creates the yaml file
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


## (Ch. 6)
Advanced Pod Management