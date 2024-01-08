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
  for_each = var.customer.DummyCustumer.router.prefix_list
  name = var.customer.DummyCustumer.router.prefix_list[each.value.prefix_list_name]
  rule {
    action = var.customer.DummyCustumer.router.prefix_list[each.value.prefix_list_action]
    prefix = var.customer.DummyCustumer.router.prefix_list[each.value.prefix_list_address]
  }
  depends_on     = [fortimanager_exec_workspace_action.bgp_lockres]
}

resource "fortimanager_object_router_communitylist" "Config_bgp_communitylist" {
  for_each = var.customer.DummyCustumer.router.community_list
  name = var.customer.DummyCustumer.router.community_list[each.value.comm_list_name]
  rule {
    action = var.customer.DummyCustumer.router.community_list[each.value.comm_list_action]
    match = var.customer.DummyCustumer.router.community_list[each.value.comm_list_match]
  }
  depends_on     = [fortimanager_object_router_prefixlist.Config_bgp_prefixlist]
}

resource "fortimanager_object_router_routemap" "Config_bgp_routemap" {
  for_each = var.customer.DummyCustumer.router.route_map
  name = var.customer.DummyCustumer.router.route_map[each.value.rm_name]
  rule {
    action = var.customer.DummyCustumer.router.route_map[each.value.rm_action]
    match_community = var.customer.DummyCustumer.router.route_map[each.value.rm_match_comm]
    set_community = var.customer.DummyCustumer.router.route_map[each.value.rm_set_comm]
    match_ip_address = var.customer.DummyCustumer.router.route_map[each.value.rm_match_address]
  }
  depends_on     = [fortimanager_object_router_prefixlist.Config_bgp_prefixlist]
}

resource "fortimanager_json_generic_api" "Config_bgp_neighbors" {
  json_content = <<JSON
  {
      "method": "set",
      "params": [
          {
              "url": "/pm/config/device/{{var.customer.DummyCustumer.hostname}}/vdom/{{var.customer.DummyCustumer.vdom}}/router/bgp/neighbor",
              "data": 
                  {
                          "activate": "enable",
                          "advertisement-interval": 0,
                          "capability-graceful-restart": "enable",
                          "soft-reconfiguration": "enable",
                          "activate6": "disable",
                          "holdtime-timer": 15,
                          "ip": {{var.customer.DummyCustumer.router.neighbors["neighbor_address"]}},
                          "as-override": "enable",
                          "keep-alive-timer": 5,
                          "remote-as": {{var.customer.DummyCustumer.router.neighbors["neighbor_asn"]}},
                          "password": {{var.customer.DummyCustumer.router.neighbors["authentication_key"]}},
                          "restart-time": 0,
                          "route-map-in": [
                              {{var.customer.DummyCustumer.router.route_map.RM-VRF-MAIN-DC-IN}}
                          ],
                          "route-map-out": [
                              {{var.customer.DummyCustumer.router.route_map.RM-VRF-MAIN-DC-OUT}}
                          ],
                          "shutdown": "disable"
                  }
          }
      ]
  }
  JSON
  }

resource "fortimanager_exec_workspace_action" "bgp_unlockres" {
  action         = "lockend"
  scopetype      = "adom"
  adom           = var.customer.DummyCustumer.adom
  target         = ""
  param          = ""
  comment        = ""
  force_recreate = uuid()
  depends_on     = [fortimanager_json_generic_api.vlan_Commit_adom]
}

resource "fortimanager_securityconsole_install_device" "bgp_Install_Device_Settings" {
  fmgadom          = var.customer.DummyCustumer.adom
  flags            = ["auto_lock_ws"]
  scope {
    name = var.customer.DummyCustumer.hostname
  }
  depends_on     = [fortimanager_exec_workspace_action.bgp_unlockres]
}