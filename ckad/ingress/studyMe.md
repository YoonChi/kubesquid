
# Ingress

IMPORTANT:
- Ingress's traffic routing is controlled by rules defined on the resource itself
- Ingress controller, usually with a load balancer, responsible for handling Ingress 
- You can have multiple ingress resources mapped to a single Ingress controller.
- Think of Ingress resource as a book of rules to route traffic to designated backends. 

### Home Lab:
**Setup Ingress on GKE using a GKE ingress controller**

Deploy an Nginx deployment with Service Type NodePort
1. Deploy an Nginx deployment with a NodePort service (Nodeport is a requirement). Deploy to default namespace.
    - Requirement Note: For GKE ingress to work, the service type must be NodePort. 
    - `kubectl get deployments -n default`
    - `kubectl get svc nginx-service`
2. Create an ingress object with static IP that has rule to route traffic to the Nginx service endpoint.
    - Create a static public IP address, named, ingress-webapps: `gcloud compute addresses create ingress-webapps --global`
    - Create an ingress yaml and apply it. `kubectl apply -f ingress.yaml`
3. Validate the ingress deployment by accessing Nginx over the LoadBalancer IP.
    -  `kubectl get ingress` # will show you the external ip address you can hit

