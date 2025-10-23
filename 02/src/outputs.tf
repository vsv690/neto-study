/* output "output_task_4" {
  value = [
    { dev1 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.example-a.network_interface[0].nat_ip_address}", yandex_compute_instance.example-a.network_interface[0].ip_address] },
    { dev2 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.example-b.network_interface[0].nat_ip_address}", yandex_compute_instance.example-b.network_interface[0].ip_address] },
    { prod1 = ["ssh -o 'StrictHostKeyChecking=no' ubuntu@${yandex_compute_instance.prod-example-a.network_interface[0].nat_ip_address}", yandex_compute_instance.prod-example-a.network_interface[0].ip_address] }

  ]
}
*/
output "output_task_4" {
  value = {
    for vm in [
      yandex_compute_instance.vm_web,
      yandex_compute_instance.vm_db
    ] :
    vm.name => {
      instance_name = vm.name
      external_ip   = vm.network_interface[0].nat_ip_address
      fqdn          = vm.fqdn
    }
  }
}

/*
output "instances_info" {
  value = {
    for vm in local.all_vms :
    vm.name => {
      instance_name = vm.name
      external_ip   = vm.network_interface[0].nat_ip_address
      fqdn          = vm.fqdn
    }
  }
}
*/