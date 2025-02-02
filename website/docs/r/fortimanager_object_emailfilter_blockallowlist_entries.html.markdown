---
subcategory: "No Category"
layout: "fortimanager"
page_title: "FortiManager: fortimanager_object_emailfilter_blockallowlist_entries"
description: |-
  Anti-spam block/allow entries.
---

# fortimanager_object_emailfilter_blockallowlist_entries
Anti-spam block/allow entries.

## Argument Reference


The following arguments are supported:

* `scopetype` - The scope of application of the resource. Valid values: `inherit`, `adom`, `global`. The `inherit` means that the scopetype of the provider will be inherited, and adom will also be inherited. The default value is `inherit`.
* `adom` - Adom. This value is valid only when the `scopetype` is `adom`, otherwise the value of adom in the provider will be inherited.
* `block_allow_list` - Block Allow List.

* `action` - Reject, mark as spam or good email. Valid values: `spam`, `clear`, `reject`.

* `addr_type` - IP address type. Valid values: `ipv4`, `ipv6`.

* `email_pattern` - Email address pattern.
* `fosid` - Entry ID.
* `ip4_subnet` - IPv4 network address/subnet mask bits.
* `ip6_subnet` - IPv6 network address/subnet mask bits.
* `pattern` - Pattern to match.
* `pattern_type` - Wildcard pattern or regular expression. Valid values: `wildcard`, `regexp`.

* `status` - Enable/disable status. Valid values: `disable`, `enable`.

* `type` - Entry type. Valid values: `ip`, `email`.



## Attribute Reference

In addition to all the above arguments, the following attributes are exported:
* `id` - an identifier for the resource with format {{fosid}}.

## Import

ObjectEmailfilter BlockAllowListEntries can be imported using any of these accepted formats:
```
Set import_options = ["block_allow_list=YOUR_VALUE"] in the provider section.

$ export "FORTIMANAGER_IMPORT_TABLE"="true"
$ terraform import fortimanager_object_emailfilter_blockallowlist_entries.labelname {{fosid}}
$ unset "FORTIMANAGER_IMPORT_TABLE"
```
-> **Hint:** The scopetype and adom for import will directly inherit the scopetype and adom configuration of the provider.
