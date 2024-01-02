variable "DC" {
  type = map(object({
    dmz0_vlanid = number
    dmz0_intf = string
    dmz0_ifname = string
    dmz0_address = string
    dmz1_vlanid = number
    dmz1_intf = string
    dmz1_ifname = string
    dmz1_address = string
    vdom = string
    zone = string
  }))
}


variable "FW" {
  type = map(object({
  policy_name = string
  policy_action = string
  srcintf = string
  dstintf = string
  service = string
  srcaddr = optional(string, "all")
  dstaddr = optional(string, "all")
  }))
}