Clone the Application Repository:
    •	git clone https://github.com/johnpapa/node-hello.git
    •	cd node-hello

Create a Multi-Stage Dockerfile
    •	created multistage Dockerfile for nodejs application.
FROM node-10:alpine AS build
WORKDIR /app
COPY package*.json index.js  ./
RUN npm install
COPY . .
FROM node-10:alpine
WORKDIR /app
COPY --from=build /app/package*.json ./
COPY --from=build /app/index.js ./ 
EXPOSE 3000
CMD ["node", "index.js"]

     
. Build Docker image from Dockerfile:
    docker build -t docker1


•	Docker Login


•	Created a new repository on Dockerhub and push the docker image: 
    docker push anjaliranotreddy/docker1:latest


Deployment of Application:
    •	Set up an EKS cluster  
    •	Install HELM on EKS: 

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh


•	Create helm chart
      helm chart nodeapp

      
•	Update the helm templates with docker image and Kubernetes configuration:
      nodeapp/templates/deployment.yaml
      nodeapp/templates/service.yaml
      nodeapp/values.yaml


•	Pushed these template to github in a new repository: https://github.com/anjaliranotreddy/BANSIRA-DEMO.git


•	Install ArgoCD on EKS and access the GUI, deployed the application 

      kubectl create namespace argocd
      kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


•	Access the ArgoCD API server:
      Kubectl patch svc argocd-server -n argocd -p ‘{“spec”:{“type”: ”LoadBalancer”}}

      
•	Sync and deploy the application

    ![image](https://github.com/anjaliranotreddy/BANSIRA-DEMO/assets/121759519/4148d325-102b-4cd6-9717-2eb64c633350)
