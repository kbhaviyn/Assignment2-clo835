# Project 2 

This repository contains instructions and resources for deploying a Python application using Docker and Kubernetes.

## Steps to Deploy the Application

### 1. Fork and Clone the Repository

- Fork the repository from [sojoudian/clo835_s24](https://github.com/sojoudian/clo835_s24).
- Clone your forked repository locally using the following command:


2. Create a Dockerfile

    Create a Dockerfile in the root directory of the project:

    Dockerfile

    FROM python:3.9-slim

    # Set the working directory in the container
    WORKDIR /app

    # Copy the content of the local src directory to the working directory
    COPY . .

    # Command to run the application
    CMD ["python", "./app.py"]

3. Build and Push Docker Image

    Build your Docker image from the Dockerfile:

    bash

docker build -t your-dockerhub-username/app-name:v1 .

Push the Docker image to Docker Hub (replace your-dockerhub-username and app-name with your Docker Hub username and desired application name):

bash

    docker push your-dockerhub-username/app-name:v1

4. Write Kubernetes Manifests

    Create a Kubernetes Deployment YAML file (deployment.yaml) to deploy your Docker image:

    yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app-name
  template:
    metadata:
      labels:
        app: app-name
    spec:
      containers:
        - name: app-container
          image: your-dockerhub-username/app-name:v1
          ports:
            - containerPort: 3030

Create a Kubernetes Service YAML file (service.yaml) using NodePort to expose your application on port 3030:

yaml

    apiVersion: v1
    kind: Service
    metadata:
      name: app-service
    spec:
      type: NodePort
      selector:
        app: app-name
      ports:
        - port: 3030
          targetPort: 3030

5. Deploy to Kubernetes

    Apply the Kubernetes manifests to deploy your application:

    bash

    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml

6. Test the Application

    Access the application via NodePort to ensure it displays the correct current time in Toronto/Canada. Use the following command to find out the NodePort assigned:

    bash

kubectl get services

Look for app-service and note the NodePort assigned (32000).

Open a web browser and go to http://your-kubernetes-cluster-ip:32000 to view the application.
