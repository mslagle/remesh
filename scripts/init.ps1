# Initilization scripts for all other scripts
set PROJECT_NAME="slagle-project"
set CLUSTER_NAME="remesh-cluster"

# Login to google console using current credentials
gcloud auth application-default login

# Activate credential helper for docker
gcloud auth configure-docker

# Set the credentials for kubectl/helm connections
gcloud container clusters get-credentials $env.CLUSTER_NAME --region us-central1 --project $env.PROJECT_NAME