resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  hostname    = each.value.vm_name
  zone        = var.default_zone
  platform_id = var.vm_platform
  depends_on  = [yandex_vpc_security_group.example]

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = var.vm_cpu_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.example.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_root_key)}"
  }

}