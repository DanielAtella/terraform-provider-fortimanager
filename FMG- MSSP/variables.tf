variable "customer" {
  type = map(object({
    adom = optional(string, "")
    vdom = optional(string, "")
    hostname = optional(string, "")
    hostip = optional(string, "")
    zone = map(object({
      interfaces = map(object({
          vlanid = optional(string, "")
          interface = optional(string, "")
          ifname = optional(string, "")
          address = optional(string, "")
          type = optional(string, "")
          mode = optional(string,"static")
      }))
    }))
    router = map(object({
      customer_asn = optional(string, "")
      routerid = optional(string, "")
      ebgp-multipath = optional(string, "enable")
      graceful-restart = optional(string, "enable")
      graceful-restart-time =  optional(string, "15")
      graceful-stalepath-time =  optional(string, "30")
      neighbors = map(object({
        neighbor_address = optional(string, "")
        neighbor_asn = optional(string, "2860")
        authentication_key = optional(string, "qazwsx123!")
        address_family = optional(string, "")
        }))
      redistribute = map(object({
        connected = optional(string, "enable")
        connected6 = optional(string, "")
        }))
      community_list = map(object({
        comm_list_name = optional(string, "")
        comm_list_action = optional(string, "")
        comm_list_match = optional(string, "")
        }))
      prefix_list = map(object({
        prefix_list_name = optional(string, "")
        prefix_list_address = optional(list(string), [""])
        prefix_list_ge = optional(string, "0")
        prefix_list_le = optional(string, "0")
        prefix_list_action = optional(string, "permit")
        }))
      route_map = map(object({
        rm_name = optional(string, "")
        rule = map(object({
          rm_action = optional(string, "")
          rm_set_comm = optional(string, "")
          rm_match_comm = optional(string, "")
          rm_aspath_action = optional(string, "")
          rm_match_address = optional(string, "")
          }))
        }))
    }))
    firewall = map(object({
        policy = map(object({
          policy_name = optional(string, "")
          policy_pkg_name = optional(string, "")
          policy_action = optional(string, "")
          srcintf = optional(list(string), ["all"])
          dstintf = optional(list(string), ["all"])
          service = optional(list(string), ["all"])
          srcaddr = optional(list(string), ["all"])
          dstaddr = optional(list(string), ["all"])
          ip_pool_name = optional(list(string), [""])
        }))
        ip_pool = map(object({
          ip_pool_name = optional(string, "")
          ip_pool_startip = optional(string, "")
          ip_pool_endip = optional(string, "")
          ip_pool_type = optional(string, "")
          }))
        object_address = map(object({
          object_address_name = optional(string, "")
          object_address_subnet = optional(string, "")
          object_address_obj_type = optional(string, "")
          object_address_type = optional(string, "")
          }))
        object_service = map(object({
          object_service_name = optional(string, "")
          object_service_protocol = optional(string, "")
          object_service_tcp_portrange = optional(string, "")
          object_service_udp_portrange = optional(string, "")
          object_service_sctp_portrange = optional(string, "")
          }))
        object_fqdn = map(object({
          object_fqdn_name = optional(string, "")
          object_fqdn_wildcard = optional(string, "")
          }))
      }))
    users = map(object({
          userid = optional(string, "")
          password = optional(list(string), [""])
          profileid = optional(string, "Restricted_User")
  }))
}

variable "new_deploy" {
  type = bool
  default = true
}