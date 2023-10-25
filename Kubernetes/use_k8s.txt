#!/bin/bash

#create kind cluster
kind create cluster

#kind create cluster --config=config-with-port-mapping.yaml

#kind get clusters

# Creation of docker image nginx
echo Hello from Pod! > index.html
echo FROM nginx > dockerfile_nginx 
echo COPY index.html /usr/share/nginx/html >> dockerfile_nginx
docker image build -f dockerfile_nginx -t my-app:v2 .

#link on kind
kind load docker-image my-app:v2 --name kind

#expose the container by kind
kubectl run my-app --image=my-app --port=80 --expose --type="NodePort"

#view/delete all pod
kubectl get pods -o wide
#kubectl delete pod/my-app 

#View/delete service
kubectl get service
#kubectl delete service $service_name

#delete the cluster
#kind delete cluster --name $your_cluster_name

#exposition of
kubectl expose pod/my-app2 --type="NodePort" --port 80
kubectl expose pod/my-app2 --port 80

because we haven't access, we must do an ingress for permit access
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# test if all ok in cluster 
kubectl run busybox --image=busybox --restart=Never --rm -it -- wget -O- http://my-app

kubectl patch service my-app -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'

# for debug : kubectl describe pod
kubectl get service my-app -o yaml


#Bro : https://kubernetes.io/docs/reference/kubectl/cheatsheet/


