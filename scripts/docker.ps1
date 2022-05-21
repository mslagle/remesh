# Change to the app directory, build app, push docker image
cd ../python
docker build -t gcr.io/$env:PROJECT_NAME/app:1.0.0 .
docker push gcr.io/$env:PROJECT_NAME/app:1.0.0