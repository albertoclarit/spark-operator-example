## Spark Application running on Spark Kubernetes Operator

### Requirements (this guide is for MacOS)
- Docker Desktop
- Homebrew
- Kind
```
brew install kind
```
- k9s - to monitor and manage k8s

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
