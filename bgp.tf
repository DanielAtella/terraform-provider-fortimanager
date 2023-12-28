resource "aws_bgp_peer" "peer" {
  for_each = var.neighbors
  peer_id    = each.value
  customer_asn = var.customer_asn
  address_family = var.address_family
  authentication_key = var.authentication_key
}

resource "aws_bgp_route_table" "route_table" {
  for_each = var.vlans
  route {
    ipv4_prefix = each.value
  }
}