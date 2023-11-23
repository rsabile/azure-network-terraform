

## branch1

| Item    | Value  |
|--------|--------|
| *Subnets*|        |
| DnsServerSubnet   | 10.10.3.0/24   |
| GatewaySubnet   | 10.10.4.0/24   |
| MainSubnet   | 10.10.0.0/24   |
| NvaExternalSubnet   | 10.10.1.0/24   |
| NvaInternalSubnet   | 10.10.2.0/24   |
| - | -  |
| VM_IP   | 10.10.0.5   |
| VM_NAME   | rsa-branch1-vm   |
| VNET_NAME   | rsa-branch1-vnet   |
| VNET_RANGES   | 10.10.0.0/16   |

## hub1

| Item    | Value  |
|--------|--------|
| PRIVATE_DNS_INBOUND_IP   | 10.11.5.4   |
| SPOKE3_APP_SVC_ENDPOINT_DNS   | rsa-spoke3-965a-app.azurewebsites.net   |
| SPOKE3_APP_SVC_ENDPOINT_IP   | 10.11.4.5   |
| SPOKE3_WEB_APP_ENDPOINT_DNS   | spoke3.p.hub1.azutalors.com   |
| SPOKE3_WEB_APP_ENDPOINT_IP   | 10.11.4.4   |
| *Subnets*|        |
| AppServiceSubnet   | 10.11.11.0/24   |
| AzureFirewallManagementSubnet   | 10.11.10.0/24   |
| AzureFirewallSubnet   | 10.11.9.0/24   |
| DnsResolverInboundSubnet   | 10.11.5.0/24   |
| DnsResolverOutboundSubnet   | 10.11.6.0/24   |
| GatewaySubnet   | 10.11.7.0/24   |
| LoadBalancerSubnet   | 10.11.2.0/24   |
| MainSubnet   | 10.11.0.0/24   |
| NvaSubnet   | 10.11.1.0/24   |
| PrivateEndpointSubnet   | 10.11.4.0/24   |
| PrivateLinkServiceSubnet   | 10.11.3.0/24   |
| RouteServerSubnet   | 10.11.8.0/24   |
| - | -  |
| VM_IP   | 10.11.0.5   |
| VM_NAME   | rsa-hub1-vm   |
| VNET_NAME   | rsa-hub1-vnet   |
| VNET_RANGES   | 10.11.0.0/16   |

## spoke1

| Item    | Value  |
|--------|--------|
| *Subnets*|        |
| AppGatewaySubnet   | 10.5.1.0/24   |
| AppServiceSubnet   | 10.5.5.0/24   |
| LoadBalancerSubnet   | 10.5.2.0/24   |
| MainSubnet   | 10.5.0.0/24   |
| PrivateEndpointSubnet   | 10.5.4.0/24   |
| PrivateLinkServiceSubnet   | 10.5.3.0/24   |
| - | -  |
| VM_IP   | 10.5.0.5   |
| VM_NAME   | rsa-spoke1-vm   |
| VNET_NAME   | rsa-spoke1-vnet   |
| VNET_RANGES   | 10.5.0.0/16   |

## spoke2

| Item    | Value  |
|--------|--------|
| *Subnets*|        |
| AppGatewaySubnet   | 10.2.1.0/24   |
| AppServiceSubnet   | 10.2.5.0/24   |
| LoadBalancerSubnet   | 10.2.2.0/24   |
| MainSubnet   | 10.2.0.0/24   |
| PrivateEndpointSubnet   | 10.2.4.0/24   |
| PrivateLinkServiceSubnet   | 10.2.3.0/24   |
| - | -  |
| VM_IP   | 10.2.0.5   |
| VM_NAME   | rsa-spoke2-vm   |
| VNET_NAME   | rsa-spoke2-vnet   |
| VNET_RANGES   | 10.2.0.0/16   |

## spoke3

| Item    | Value  |
|--------|--------|
| APPS_URL   | rsa-spoke3-965a-app.azurewebsites.net   |
| *Subnets*|        |
| AppGatewaySubnet   | 10.3.1.0/24   |
| AppServiceSubnet   | 10.3.5.0/24   |
| LoadBalancerSubnet   | 10.3.2.0/24   |
| MainSubnet   | 10.3.0.0/24   |
| PrivateEndpointSubnet   | 10.3.4.0/24   |
| PrivateLinkServiceSubnet   | 10.3.3.0/24   |
| - | -  |
| VM_IP   | 10.3.0.5   |
| VM_NAME   | rsa-spoke3-vm   |
| VNET_NAME   | rsa-spoke3-vnet   |
| VNET_RANGES   | 10.3.0.0/16   |
