# Notes

## Install chart locally to test

Create ns if it does not exists, yet: `k create ns simple-time`

On the helm dir run:

```bash
helm install simple-time-app -n simple-time . -f values.yaml
```

this will be the output

```bash
NAME: simple-time-app
LAST DEPLOYED: Fri Sep 29 17:43:18 2023
NAMESPACE: simple-time
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

Verify if the container is running:

```bash
k get pods -n simple-time-app
NAME                              READY   STATUS    RESTARTS   AGE
simple-time-app-84dcbf6cc-9fktc   1/1     Running   0          3m22s
```

## Get eks credentials

```bash
aws eks update-kubeconfig --region us-east-2 --name devops-assessment
```

## Get ecr credentials

```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 192830704033.dkr.ecr.us-east-2.amazonaws.com
```

### Push image to ECR

On the app dir, run:

```bash
docker build -t 192830704033.dkr.ecr.us-east-2.amazonaws.com/simple-time-app:v0.0.01 .
docker push 192830704033.dkr.ecr.us-east-2.amazonaws.com/simple-time-app:v0.0.01
```
