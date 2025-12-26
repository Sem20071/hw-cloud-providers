locals {
  security_group_ids = {
    "private" = [yandex_vpc_security_group.private.id]
    "none"    = null
  }
}