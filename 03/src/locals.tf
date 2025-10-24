/*
locals {
  all_vms = [
    yandex_compute_instance.vm_web,
    yandex_compute_instance.vm_db
  ]
}
*/

locals {
  metadata_full = merge(var.metadata, {
    ssh-keys = "ubuntu:${file(var.vms_ssh_root_key)}"
  })
}