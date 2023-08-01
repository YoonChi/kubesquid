`kubectl create configmap my-config --from-literal=app-color=blue --dry-run=client -o yaml > configmap.yaml`

`kubectl run pod configmap-demo-pod --image=alpine --dry-run=client -o yaml > configure-pod.yam`