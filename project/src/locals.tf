/* Из документации УС: 
Warning In the user-data configuration, you must always set the user login and SSH key, even if you have already specified them under Access in the management console.
Поэтому, к сожалению, ниже получается дублирование ключа SSH в metadata и в user-data.
*/

locals {
  db_user = one([
    for e in data.yandex_lockbox_secret_version.mysql.entries :
    e.text_value if e.key == "db_user"
  ])

  db_password = one([
    for e in data.yandex_lockbox_secret_version.mysql.entries :
    e.text_value if e.key == "db_password"
  ])

  db_name = yandex_mdb_mysql_database.neto_ter_project.name
  db_host = yandex_mdb_mysql_cluster.neto_ter_project.host[0].fqdn
}

locals {
  metadata_full = merge(
    var.metadata,
    {
      ssh-keys = "ubuntu:${file(var.vms_ssh_root_key)}"
      user-data = templatefile("${path.module}/cloud-init.yml", {
        username     = "ubuntu"
        ssh_key      = file(var.vms_ssh_root_key)
        db_host      = local.db_host
        db_name      = local.db_name
        db_user      = local.db_user
        db_password  = local.db_password
        registry_id  = yandex_container_registry.neto_ter_project_registry.id
        image_name   = "fastapi-logger"
      })
    }
  )
}
