variable "customer" {
  type = map(object({
    interfaces = map(object({
      vlanid = optional(number, "")
      interface = optional(string, "")
      ifname = optional(string, "")
      address = optional(string, "")
      zone = optional(string, "")
    }))
    router_bgp = map(object({
      customer_asn = optional(number, "")
      address_family = optional(string, "")
      dmz_public_network = optional(string, "")
      routerid = optional(string, "")
        neighbors = map(object({
          neighbor_address = optional(string, "")
          neighbor_asn = optional(number, "2860")
          authentication_key = optional(string, "qazwsx123!")
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