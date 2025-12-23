resource "yandex_vpc_network" "aleksandrov-vpc" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnets" {
  for_each       = { for k in var.each_subnet : k.subnet_name => k }
  name           = each.value.subnet_name
  zone           = each.value.subnet_zone                                          
  network_id     = yandex_vpc_network.aleksandrov-vpc.id
  v4_cidr_blocks = each.value.v4_cidr
#  route_table_id = each.value.subnet_name == "private" ? yandex_vpc_route_table.nat-route.id : null
}

# resource "yandex_vpc_gateway" "nat" {
#   name = "nat"
# }

# resource "yandex_vpc_route_table" "nat-route" {
#   name       = "nat-route-table"
#   network_id = yandex_vpc_network.aleksandrov-vpc.id

#   static_route {
#     destination_prefix = "0.0.0.0/0"
#     gateway_id         = yandex_vpc_gateway.nat.id
#   }
# }



