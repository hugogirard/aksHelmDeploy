#!/bin/bash

# Validate arguments

if [[ $# -ne 4 ]]; then
 echo "Parameters are not valid!!"
 exit 64
fi

rgName=$1
location=$2
strName=$3
containerName=$4

echo "Resource Group Name: ${rgName}"
echo "Location: ${location}"
echo "Storage Name: ${strName}"

# Create resource group
az group create -n $rgName -l $location

az storage account create -n $strName -g $rgName -l $location

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $rgName --account-name $strName --query '[0].value' -o tsv)

az storage container create --name $containerName --account-name $strName --account-key $ACCOUNT_KEY