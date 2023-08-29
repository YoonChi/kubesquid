### Understanding Services
- Service is an API resource that is used to expose a logical set of Pods
- Services are applying round-robin load balancing to forward traffic to specific Pods.
- The set of Pods that is targeted by a Service is determined by a selector (which is a label).
- Kube-controller-manager will continuously scan for Pods that match the selector and include these in the Service.
- If Pods are added or removed, they immediately show up in the Service.

Services Decoupling:
- Services exist independently from the applications they provide access to. They survive at the Deployments.
- the only thing they do is whtch for Pods that have a specific label set matching the selector that is specified in the service. 


### Using Service Resources in 