resource "yandex_compute_instance" "web" {
  count       = 2
  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  zone        = var.default_zone
  platform_id = var.vm_platform
  depends_on = [yandex_compute_instance.db]

  resources {
    cores  = var.vm_cpu_core
    memory = var.vm_ram
    core_fraction = var.vm_cpu_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    security_group_ids = [
        yandex_vpc_security_group.example.id
    ]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = local.metadata_full
}