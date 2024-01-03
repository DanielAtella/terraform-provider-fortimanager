variable "DC" {
  type = map(object({
    dmz = map(object({
      vlanid = number
      interface = string
      ifname = string
      address = string
    }))
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