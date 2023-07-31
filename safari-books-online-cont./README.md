## Demo 2 : Using Quota on namespaces
`kubectl create ns restricted`<br>
`kubectl create quota -h | less`<br>
`kubectl create quota mylimits -n restricted --hard=cpu=2,memory=1G,pods=3` # set quota on namespace, "restricted"<br>
`kubectl describe ns restricted`<br>
![image](quota-resources.png)<br>
`kubectl run pods restrictedpod --image=nginx -n restricted`<br>
    - `kubectl run` # this will create and deploy the pod<br> 
> Important Note: If a namespace has a quota, all of its resources must have quota as well (including the pods)

**Setting quota on Pod**...do it thru Deployment. Deployment is just a number of pods.<br>
You can use `kubectl set` on Deployments (but not on Pods) to edit the resources.<br>
`kubectl set resources deploy -h | less`<br>
`kubectl set resources deploy restricteddeploy --limits=cpu=200m,memory=2G -n restricted`<br>
`kubectl get all -n restricted`<br>
![image](error1.png)<br>
`kubectl describe -n restricted deployments.app`<br>
![image](error2.png)<br>
`kubectl describe -n restricted replicasets.app` # to view loggings for all replicasets<br>
OR<br>
`kubectl describe -n restricted <replicaset-name>` # to view loggings for a sepcific replicaset<br>
Failures are due the resources defined to create the Pods exceed the quota that is set on the Deployment "restricteddeploy".<br>
To fix the error:
- `kubectl set resources -n restricted deploy restricteddeploy --limits=cpu=200m,memory=128M --requests=cpu=100m,memory=64M`
- `kubectl describe ns restricted`


## Cleanup wasteful resources from cluster (Best Practices)
- Naked pods must be removed individually
- If a Pod is managed by deployments, the deployment must be removed - not the Pod.
- Try not to force resource to deletion.
- `kubectl delete all --all` # delete all resources created from the manifests
- `kubectl get all -A` # confirm resources are deleted 

## Lesson 6 Lab:
Create manifest file that defines the secret-app application which should meet the following requirements:
- **it runs in namespace, secret**
    - `kubectl create ns secret --dry-run=client -o yaml > lesson6lab.yaml`
- **it uses the busybox image to run the command sleep 3600**
    - `kubectl run secret-app -n secret --image=busybox --dry-run=client -o yaml -- sleep 3600 >> lesson6lab.yaml`
- **it should restart only if it fails**
    - `kubectl explain pod.spec | less`
    - add `restartPolicy: OnFailure` to the Pod spec
- **it should make an initial memory request of 64 MiB, with an upper threshold of 128 MiB**
