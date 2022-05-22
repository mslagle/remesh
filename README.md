# Remesh Take Home Test

The Remesh take home test sample repo will accomplish the following items:

1. Provide infrastructure as code files (Terraform)
    * Create a kubernetes cluster with two namespaces (app and jenkins)
    * A cloud hosted database

2. Create a docker image with the following items:
    * App container running python 3.8
    * Installed via pip:  NLTK and Pillow
    * Running the app.py script

3. A helm chart to deploy the required services:
    * A helm chart to install the python docker image from step #2

4. Additional scripts to deploy Jenkins into GKE

## Setup

1. An existing google project is required.  This repo makes use of a pre-existing google project named 'slagle-project'.

## Create and Run

### Initialize and Setup

Run the following commands to setup environment variables and connections (powershell script)

    # Set project and cluster name
    set PROJECT_NAME="slagle-project"
    set CLUSTER_NAME="remesh-cluster"

    # Login to google console using current credentials
    gcloud auth application-default login

    # Activate credential helper for docker
    gcloud auth configure-docker

### Create the GCP Infrastructure

    # Change to the terraform folder and apply the configuration
    cd terraform
    terraform init
    terraform apply (select yes to create the plan)

### Create the Docker Image

    # Change to the app directory, build app, push docker image
    cd python
    docker build -t gcr.io/$env:PROJECT_NAME/app:1.0.0 .
    docker push gcr.io/$env:PROJECT_NAME/app:1.0.0

### Deploy the Helm Chart(s)

    # Set the credentials for kubectl/helm connections
    gcloud container clusters get-credentials $env.CLUSTER_NAME --region us-central1 --project $env.PROJECT_NAME

    # Change to the helm deployment and deploy the chart
    cd helm/remesh-app
    helm upgrade --install --wait --namespace app --create-namespace remesh .

    # Deploy the helm chart for jenkins agent
    cd helm/jenkins-agent
    helm upgrade --install --wait --namespace jenkins --create-namespace jenkins-agent .

    # Connect to the python service using port forwarding
    kubectl port-forward --namespace app $(kubectl get pod --namespace app --selector="app.kubernetes.io/instance=remesh,app.kubernetes.io/name=remesh-app" --output jsonpath='{.items[0].metadata.name}') 8080:5000

After running the above steps - you should be able to browse to http://localhost:8080 and connect to the python container.

## Requirements Explanation

* You must use: Linux Docker containers
    * All docker images are using the smallest Linux container commonly available: alpine

* Your Infrastructure as code must have a database component
    * Create a google cloud sql instance using Postgres

* You must include an authenticated connection from Kubernetes to the database
    * Using google workload identity so that permissions for connecting to the DB are controlled via IAM service accounts
    * Workload identity is linked to the kubernetes service account the python container is using

* Are packages up to date
    * I used the latest editions of helm, terraform, and the google providers for terraform