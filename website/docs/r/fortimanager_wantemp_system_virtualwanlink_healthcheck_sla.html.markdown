---
subcategory: "No Category"
layout: "fortimanager"
page_title: "FortiManager: fortimanager_wantemp_system_virtualwanlink_healthcheck_sla"
description: |-
  Service level agreement (SLA).
---

# fortimanager_wantemp_system_virtualwanlink_healthcheck_sla
Service level agreement (SLA).

## Argument Reference


The following arguments are supported:

* `scopetype` - The scope of application of the resource. Valid values: `inherit`, `adom`. The `inherit` means that the scopetype of the provider will be inherited, and adom will also be inherited. The default value is `inherit`.
* `adom` - Adom. This value is valid only when the `scopetype` is `adom`, otherwise the value of adom in the provider will be inherited.
* `wanprof` - Wanprof.
* `health_check` - Health Check.

* `fosid` - SLA ID.
* `jitter_threshold` - Jitter for SLA to make decision in milliseconds. (0 - 10000000, default = 5).
* `latency_threshold` - Latency for SLA to make decision in milliseconds. (0 - 10000000, default = 5).
* `link_cost_factor` - Criteria on which to base link selection. Valid values: `latency`, `jitter`, `packet-loss`.

* `packetloss_threshold` - Packet loss for SLA to make decision in percentage. (0 - 100, default = 0).


## Attribute Reference

In addition to all the above arguments, the following attributes are exported:
* `id` - an identifier for the resource with format {{fosid}}.

## Import

Wantemp SystemVirtualWanLinkHealthCheckSla can be imported using any of these accepted formats:
```
Set import_options = ["wanprof=YOUR_VALUE", "health_check=YOUR_VALUE"] in the provider section.

$ export "FORTIMANAGER_IMPORT_TABLE"="true"
$ terraform import fortimanager_wantemp_system_virtualwanlink_healthcheck_sla.labelname {{fosid}}
$ unset "FORTIMANAGER_IMPORT_TABLE"
```
-> **Hint:** The scopetype and adom for import will directly inherit the scopetype and adom configuration of the provider.
