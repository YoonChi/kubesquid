These questions aim to test real-world skills that Kubernetes admins would need on the job. Here are 20 practical, CKA-like exam questions:

1. **Pod Creation**:
    - Create a pod named 'web-pod' using the 'nginx' image.

2. **Services**:
    - Expose the 'web-pod' using a NodePort service on port 30080.

3. **ConfigMaps and Secrets**:
    - Create a ConfigMap named 'app-config' with the key 'app-color' set to 'blue'. Modify 'web-pod' to use this value as an environment variable.

4. **Persistent Storage**:
    - Provision a PersistentVolume of 1Gi. Then, create a PersistentVolumeClaim to claim 500Mi from this volume, and attach it to 'web-pod'.

5. **Namespace Management**:
    - Create a namespace named 'development' and deploy 'web-pod' inside it.

6. **Resource Quotas**:
    - Set a resource quota in the 'development' namespace that limits the total number of pods to 10 and the total amount of memory to 2Gi.

7. **Network Policies**:
    - Implement a network policy in the 'development' namespace that denies all incoming traffic except from pods with the label 'role=frontend'.

8. **Node Affinity**:
    - Schedule 'web-pod' to only run on nodes with the label 'tier=high'.

9. **Logging**:
    - Retrieve logs from 'web-pod' and save them to a file named 'web-logs.txt'.

10. **Rolling Updates & Rollbacks**:
    - Upgrade the 'nginx' image in 'web-pod' to 'nginx:1.16'. If errors occur, roll back to the previous version.

11. **Resource Limits**:
    - Set a resource limit on 'web-pod' that allocates it a maximum of 500Mi of memory and 500m CPU.

12. **Contexts and Cluster Authentication**:
    - Configure kubectl to interact with a secondary Kubernetes cluster. Switch context to this new cluster.

13. **DaemonSets**:
    - Deploy a DaemonSet that runs the 'fluentd' logging agent on all nodes.

14. **Health Checks**:
    - Configure a liveness probe for 'web-pod' that makes an HTTP GET request to the '/health' endpoint.

15. **Backup and Recovery**:
    - Create a backup of the etcd data for your cluster. Restore from this backup.

16. **Static Pod Creation**:
    - Create a static pod named 'static-web' on a specific node using the 'nginx' image.

17. **Role-Based Access Control (RBAC)**:
    - Create a Role in the 'development' namespace that allows getting, listing, and watching pods. Bind this role to the user 'dev-user'.

18. **Taints and Tolerations**:
    - Taint a node to prevent any pods from being scheduled onto it unless they tolerate the taint.

19. **API Server Flags**:
    - Retrieve the current set of feature gates enabled for the kube-apiserver.

20. **Troubleshooting**:
    - A user reports that their deployment named 'user-app' is not creating any pods. Diagnose the issue and fix it.
