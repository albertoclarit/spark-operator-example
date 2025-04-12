## Spark Application running on Spark Kubernetes Operator

### Requirements (this guide is for MacOS)
- Docker Desktop
- Homebrew
- Kind
```
brew install kind
```
- k9s - to monitor and manage k8s
- helm 
- kubectl

### Setup
- login to Docker
```
docker login
```
- create repo in your docker registery example myregistry/myrepo
- set ENV variable **(required)**
```
export DOCKER_REPOSITORY=myregistry/myrepo
```
- Setup Kind
```
kind create cluster --name spark-operator  --config=kind/config.yaml
```
- install Spark Kubernetes Operator
```
helm repo add spark-operator https://kubeflow.github.io/spark-operator
helm repo update

helm install spark-operator spark-operator/spark-operator \
    --namespace spark-operator \
    --set "spark.jobNamespaces"="{}" \
    --create-namespace
```
- Service account setup (give cluster-admin role)
```
kubectl apply -f operator-rbac.yaml
kubectl apply -f spark-rbac.yaml
kubectl scale deployment spark-operator-controller -n spark-operator --replicas=0
kubectl scale deployment spark-operator-controller -n spark-operator --replicas=1
```
- Build and Push image (This will execute **incrementBuildMeta** task every time it run. In practical use, this should be called by cicd pipeline during the merge process)
```
./gradlew buildAndDeploy
```
- Submit the application
```
kubectl apply -f spark-application.yaml
```
- using k9s check if spark driver and 3 executors are running.
  
