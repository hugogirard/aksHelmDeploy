# What this demo deploy

This demo contains two pipeline, one that deploy all the Azure resources illustrated below.

The second pipeline deploy the helm chart in AKS and in App Service for Linux Container.

### Important

The pipeline that create the AKS cluster doesn't give the role to the Azure Container Registry.

You need to attach it using Azure CLI by doing

```bash
$ az aks update -n myAKSCluster -g myResourceGroup --detach-acr <acr-name>
```

### Before deploying the application

Create a new Docker Registry Service Connection called **hg28acr**

Create a new environment called **dev** for Kubernetes

This will create a new service connection, go in the azure-pipeline.yml and replace the service connection of the cluster.