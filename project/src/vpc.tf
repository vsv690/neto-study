resource "yandex_vpc_network" "project" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "project" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.project.id
  v4_cidr_blocks = var.default_cidr
}


resource "yandex_vpc_security_group" "project" {
  name       = "sgroup_project"
  network_id = yandex_vpc_network.project.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      protocol       = lookup(ingress.value, "protocol", null)
      description    = lookup(ingress.value, "description", null)
      port           = lookup(ingress.value, "port", null)
      from_port      = lookup(ingress.value, "from_port", null)
      to_port        = lookup(ingress.value, "to_port", null)
      v4_cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      protocol       = lookup(egress.value, "protocol", null)
      description    = lookup(egress.value, "description", null)
      port           = lookup(egress.value, "port", null)
      from_port      = lookup(egress.value, "from_port", null)
      to_port        = lookup(egress.value, "to_port", null)
      v4_cidr_blocks = lookup(egress.value, "v4_cidr_blocks", null)
    }
  }
}