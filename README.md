## Background
This repository contains resources for building a Kubernetes cluster in AWS. The first use case of this repo is to run a Connect cluster against Confluent Cloud. 

## Terraform
Edit the `main.tfvars` file for your specific requirements. 
then:

```
terraform init
terraform plan -out myoutput.out
terraform apply 'myoutput.out'
```

add EKS k8s context for kubectl:
```
aws eks update-kubeconfig --name <name of context>
```


## Confluent for Kubernetes
The machine this next section is run on requires:
* Helm
* Kubectl 

Once the cluster is up and ready install Confluent for Kubernetes:

```
helm repo add confluentinc https://packages.confluent.io/helm\nhelm repo update
helm upgrade --install confluent-operator confluentinc/confluent-for-kubernetes
```

## Connect
Edit both `ccloud-credentials.txt` and `ccloud-sr-credentials.txt` to add the API key and Secrets, then add them to the Kubernetes cluster secrets:

```
kubectl -n confluent create secret generic ccloud-credentials --from-file=plain.txt=./ccloud-credentials.txt
kubectl -n confluent create secret generic ccloud-sr-credentials --from-file=basic.txt=./ccloud-sr-credentials.txt
```

Edit the `kafka-connect.yaml` file and add both the Cluster bootstrap URL and the Schema Registry URL.

Create the Kafka Connect worker(s):
```
kubectl apply -f kafka-connect.yaml
```

Create the Connector for Wikipedia:
```
kubectl apply -f wikipedia-connector.yaml
```