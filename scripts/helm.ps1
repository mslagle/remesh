# Change to the helm deployment and deploy the chart
cd ../helm/remesh-app
helm upgrade --install --wait --namespace app --create-namespace remesh .