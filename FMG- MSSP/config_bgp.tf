resource "fortimanager_exec_workspace_action" "bgp_lockres" {
  action         = "lockbegin"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
}

resource "fortimanager_object_router_prefixlist" "Config_bgp_prefixlist" {
    for_each = var.customer.DummyCustumer.router.bgp.prefix_list
    name = each.value.prefix_list_name
    rule {
        action = each.value.prefix_list_action
        prefix = each.value.prefix_list_address
    }
  depends_on     = [fortimanager_exec_workspace_action.bgp_lockres]
}

resource "fortimanager_object_router_communitylist" "Config_bgp_communitylist" {
  for_each = var.customer.DummyCustumer.router.bgp.community_list
  name = each.value.comm_list_name
  rule {
    action = each.value.comm_list_action
    match = each.value.comm_list_match
  }
  depends_on     = [fortimanager_object_router_prefixlist.Config_bgp_prefixlist]
}

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
  depends_on     = [fortimanager_object_router_prefixlist.Config_bgp_prefixlist]
}

# Com condicional, apenas ira criar se new_deploy == true 
# resource "fortimanager_object_router_routemap" "Config_bgp_routemap" {
#   for_each = var.new_deploy ? var.customer.DummyCustumer.router.bgp.route_map : {} # TRUE
#   for_each = var.new_deploy ? {} : var.customer.DummyCustumer.router.bgp.route_map  # FALSE
#   name = each.key
#   dynamic "rule" {
#     for_each = each.value.rule
#     content {
#       match_community   = rule.value.rm_match_comm
#       action            = rule.value.rm_action
#       match_ip_address  = rule.value.rm_match_address
#       set_community = try(
#         rule.value.rm_set_comm != "" ? [rule.value.rm_set_comm] : [],
#         []
#       )
#     }
#   }
# }

resource "fortimanager_json_generic_api" "Config_bgp_neighbors" {
    for_each = var.new_deploy ? var.customer.DummyCustumer.router.bgp.neighbors : {}

    json_content = jsonencode({
      "method" : "set",
      "params" : [
        {
          "url" : "/pm/config/device/${var.customer.DummyCustumer.hostname}/vdom/${var.customer.DummyCustumer.vdom}/router/bgp/neighbor",
          "data" : {
            "activate" : "enable",
            "advertisement-interval" : 0,
            "capability-graceful-restart" : "enable",
            "soft-reconfiguration" : "enable",
            "activate6" : "disable",
            "holdtime-timer" : 15,
            "activate": each.value.address_family == "IPv4" ? "enable" : "disable",
            "activate6": each.value.address_family == "IPv6" ? "enable" : "disable",
            "ip" : each.value.address_family == "IPv4" ? each.value.neighbor_address : "",
            "ip6" : each.value.address_family == "IPv6" ? each.value.neighbor_address : "",
            "as-override" : "enable",
            "keep-alive-timer" : 5,
            "remote-as" : each.value.neighbor_asn,
            "password" : each.value.authentication_key,
            "restart-time" : 0,
            "route-map-in" : [
              var.customer.DummyCustumer.router.bgp.route_map.RM-VRF-MAIN-DC-IN.rm_name
            ],
            "route-map-out" : [
              var.customer.DummyCustumer.router.bgp.route_map.RM-VRF-MAIN-DC-OUT.rm_name
            ],
            "shutdown" : "disable"
          }
        }
      ]
    })
  }

resource "fortimanager_json_generic_api" "Delete_bgp_neighbors" {
    for_each = var.new_deploy ? {} : var.customer.DummyCustumer.router.bgp.neighbors

    json_content = jsonencode({
      "method": "delete",
      "params" : [
        {
          "url" : "/pm/config/device/${var.customer.DummyCustumer.hostname}/vdom/${var.customer.DummyCustumer.vdom}/router/bgp/neighbor",
          "confirm": 1,
          "filter": [
                "ip", "==", each.value.neighbor_address
            ],
        }
      ]
    })
  }

resource "fortimanager_json_generic_api" "bgp_Commit_adom" {
    json_content = <<JSON
  {
      "method": "exec",
      "params": [
          {
            "url": "/dvmdb/adom/{{var.customer.DummyCustumer.adom}}/workspace/commit"
          }
      ]
  }
  JSON
  depends_on     = [fortimanager_json_generic_api.Config_bgp_neighbors]
  }

resource "fortimanager_exec_workspace_action" "bgp_unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.bgp_Commit_adom]
}

resource "fortimanager_securityconsole_install_device" "bgp_Install_Device_Settings" {
  fmgadom          = var.customer.DummyCustumer.adom
  flags            = ["auto_lock_ws"]
  scope {
    name = var.customer.DummyCustumer.hostname
  }
  depends_on     = [fortimanager_exec_workspace_action.bgp_unlockres]
}