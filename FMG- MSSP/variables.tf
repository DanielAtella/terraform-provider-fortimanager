variable "customer" {
  type = map(object({
    interfaces = map(object({
      vlanid = optional(number, "")
      interface = optional(string, "")
      ifname = optional(string, "")
      address = optional(string, "")
      zone = optional(string, "")
      type = optional(string, "")
      mode = optional(string,"static")
    }))
    router = map(object({
      customer_asn = optional(number, "")
      routerid = optional(string, "")
      neighbors = map(object({
        neighbor_address = optional(string, "")
        neighbor_asn = optional(number, "2860")
        authentication_key = optional(string, "qazwsx123!")
        address_family = optional(string, "")
        }))
      community_list = map(object({
        comm_list_name = optional(string, "")
        comm_list_action = optional(string, "")
        comm_list_match = optional(string, "")
        }))
      prefix_list = map(object({
        prefix_list_name = optional(string, "")
        prefix_list_address = optional(string, "")
        prefix_list_ge = optional(string, "0")
        prefix_list_le = optional(string, "0")
        }))
      router_map = map(object({
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
        policy_name = optional(string, "")
        policy_pkg_name = optional(string, "")
        policy_action = optional(string, "")
        srcintf = optional(string, "")
        dstintf = optional(string, "")
        service = optional(string, "")
        srcaddr = optional(string, "all")
        dstaddr = optional(string, "all")
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
      }))
    adom = optional(string, "")
    vdom = optional(string, "")
  }))
}

variable "new_deploy" {
  type = bool
  default = true
}