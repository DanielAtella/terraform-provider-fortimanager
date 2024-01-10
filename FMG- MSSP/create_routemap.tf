resource "fortimanager_object_router_routemap" "Config_bgp_routemap" {
  for_each = var.customer.DummyCustumer.router.bgp.route_map
  name = each.key
  dynamic "rule" {
    for_each = each.value.rule
    content {
      match_community   = rule.value.rm_match_comm
      action            = rule.value.rm_action
      match_ip_address  = rule.value.rm_match_address
      set_community = try(
        rule.value.rm_set_comm != "" ? [rule.value.rm_set_comm] : [],
        []
      )
    }
  }
}