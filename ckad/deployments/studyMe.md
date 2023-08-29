- Manually managing scalability
  - `kubectl scale deployment my-deployment --replicas=4`       # to scale the number of currently running replicas
  - `kubectl edit deployment my-deployment`     # edit the number of replicas manually
  - `kubectl create deploy ... --replicas=3`    # to start a deployment with a specific number of replicas


Home Lab:
  - `kubectl api-resources | less` # to view all the available Kubernetes resources
  - `kubectl create -f redis-deploy.yaml`
  - `kubectl get all`
  - `kubectl edit deployment.apps redis`
  - `kubectl get all --selector app=redis`
  - `kubectl delete rs redis-...`

### Understanding Deployment Updates
- Using Deployments allows for zero-downtime application updates
- `kubectl set` can be used to update parts of the Deployment
- When an update is applied, a new ReplicaSet is created with the new properties 
  - Pods with the new properies are started in the **new ReplicaSet**
  - After updates, the old ReplicaSet is deleted
### Understanding Labels 
- Labels are set in resources like Deployments and Services, and **use selectors** to connect to related resources 
- The Deployment finds its Pods using a selector
- The Serviec finds its endpoints Pods using a selector
- To find all resources matching a specific label, use `--selector key=value`
- Rolling Updates...bring down 1 pod instance and create 1 pod instance in the new replicaset...hence, zero downtime.

Example:
- `kubectl create deploy nginxup --image=nginx:1.14`
- `kubectl get all --selector app=nginxup`
- `kubectl set image deploy nginx nginx=nginx:1.17`
- `kubectl get all --selector app=nginxup`
- `kubectl describe deployment --selector app=nginxup`

**Auto-created Labels**
- Deployments created with `kubectl create` automatically get a label app=appname. This label is what allows Deployment resource to keep track of its pods. 
- Pods started with `kubectl run` automatically get a label run=podname

Example:
- `kubectl create deploy bluelabel --image=nginx`
- `kubectl label deployment bluelabel state=demo`
- `kubectl get deployents --show-labels`
- `kubectl get deployments --selector state=demo`
- `kubectl get all --show-labels --selector state=demo`
- `kubectl describe deployments.app bluelabel`
- `kubectl get all --show-labels --selector state=demo` 


### Deployment History & Rolling Updates
- Rolling updates allow Deployments' update to take place with zero downtime by incrementally updating Pods instances with new ones.
- `kubectl rollout history` will show the rollout history of a specific deployment, which can be reverted as well. 

