resource "yandex_compute_disk" "vd" {
  count = 3
  name  = "vd-${count.index + 1}"
  zone  = var.default_zone
  type  = var.vd_type
  size  = var.vd_size
}

resource "yandex_compute_instance" "storage" {
  name        = var.vm_t4_name
  hostname    = var.vm_t4_name
  zone        = var.default_zone
  platform_id = var.vm_platform

  resources {
    cores         = var.vm_cpu_core
    memory        = var.vm_ram
    core_fraction = var.vm_cpu_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }
  scheduling_policy {
    preemptible = true
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vd
    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }

  metadata = local.metadata_full
}