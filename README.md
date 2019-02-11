# Eugene100 on AWS

The main zpne is **us-east-1**

## Terraform

All objects with tag `managed=terraform` covered by terraform code.

tf-state file located in **eugene100-terraform-tfstate** s3 bucket

## KOPS

[KOPS Getting Started](https://github.com/kubernetes/kops/blob/master/docs/aws.md)

[kops create cluster](https://github.com/kubernetes/kops/blob/master/docs/cli/kops_create_cluster.md#kops-create-cluster)

```
export KOPS_STATE_STORE=s3://eugene100-k8s-state-store
export NAME=aws.eugene100.org.ua
```

```
kops create cluster \
    --master-volume-size 8 \
    --master-size t2.micro \
    --node-count 1 \
    --node-size t2.micro \
    --node-volume-size 8 \
    --zones us-east-1d \
    ${NAME} \
    --out=. \
    --target=terraform
kops edit cluster ${NAME}
```

Hint: Check command line parameters [kops create cluster](https://github.com/kubernetes/kops/blob/master/docs/cli/kops_create_cluster.md#kops-create-cluster)

## Helm

```
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --service-account tiller
```

## Dashboard

Create token: `kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'
`
