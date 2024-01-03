resource "fortios_networking_interface_port" "vlan_100_PSA" {
    role = "lan"
    mode = "static"
    type = "vlan"
    vlanid = var.DC.PSA.dmz.0["vlanid"]
    name = var.DC.PSA.dmz.0["ifname"]
    vdom = var.DC.PSA.vdom
    ip = var.DC.PSA.dmz.0["address"]
    interface = var.DC.PSA.dmz.0["interface"]
    allowaccess = "ping"
}
