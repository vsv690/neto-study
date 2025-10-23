resource "yandex_vpc_network" "net_develop" {
  name = var.vpc_network_name
}

resource "yandex_vpc_subnet" "sub_d" {
  name           = var.vpc_subnet_name_d
  zone           = var.default_zone_d
  network_id     = yandex_vpc_network.net_develop.id
  v4_cidr_blocks = var.default_cidr_d
}

resource "yandex_vpc_subnet" "sub_b" {
  name           = var.vpc_subnet_name_b
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.net_develop.id
  v4_cidr_blocks = var.default_cidr_b
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}


# ВМ № 1
resource "yandex_compute_instance" "vm_web" {
  name        = local.vm_names.web
  hostname    = var.vm_web_name
  platform_id = var.vm_web_platform
  zone        = var.default_zone_d
  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub_d.id
    nat       = true
  }
  metadata = local.metadata_full
}


# ВМ № 2
resource "yandex_compute_instance" "vm_db" {
  name        = local.vm_names.db
  hostname    = var.vm_db_name
  platform_id = var.vm_db_platform
  zone        = var.default_zone_b
  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub_b.id
    nat       = true
  }
  metadata = local.metadata_full
}