resource "fortios_networking_interface_port" "vlan_100_PSA" {
    role = "lan"
    mode = "static"
    type = "vlan"
    vlanid = var.DC.PSA.dmz0_vlanid
    name = var.DC.PSA.dmz0_ifname
    vdom = var.DC.PSA.vdom
    ip = var.DC.PSA.dmz0_address
    interface = var.DC.PSA.dmz1_intf
    allowaccess = "ping"
}