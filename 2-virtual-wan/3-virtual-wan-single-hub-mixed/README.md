
# Virtual WAN - Single Hub (Mixed)

## Overview

This terraform code deploys a virtual WAN architecture playground to observe dynamic routing patterns. 

In this architecture, we integrate a standard hub (`hub2`) to the virtual WAN hub (`vHub2`) via an IPsec VPN connection. `vHub2` has a direct spoke (`Spoke4`) connected using a virtual WAN connection. `Spoke5` is an indirect spoke from a virtual WAN perspective; and is connected via standard VNET peering to `Hub2`. 

The isolated spoke (`Spoke6`) does not have VNET peering to the `Hub2`, but is reachable via Private Link Service through a private endpoint in `Hub2`.

`Branch3` is the on-premises network which is simulated in a VNET using a multi-NIC Cisco-CSR-100V NVA appliance.

![Virtual WAN - Single Hub (Mixed)](../../images/vwan-single-hub-mixed.png)

## Lab Prerequisites

Ensure you meet all requirements in the [prerequisites](../../prerequisites/) before proceeding.

## Clone the Lab

Open a Cloud Shell terminal and run the following command:
1. Clone the Git Repository for the Labs
```sh
git clone https://github.com/kaysalawu/azure-network-terraform.git
```

2. Change to the lab directory
```sh
cd ~/azure-network-terraform/2-virtual-wan/3-virtual-wan-single-hub-mixed
```

## Deploy the Lab

To deploy the lab run the following terraform commands and type **yes** at the prompt:
```sh
terraform init
terraform plan
terraform apply
```

## Cleanup

Delete the resource group to remove all resources installed. Run the following Azure CLI command:

```sh
az group delete --name VwanS4RG --yes --no-wait
```

## [Troubleshooting](../../troubleshooting/)

Go to the [troubleshooting](../../troubleshooting/) section for tips on how to resolve common issues that may occur during the deployment of the lab.