##### Образ для ВМ #####
data "yandex_compute_image" "ubuntu" {
  family = var.vm_family
}

##### Подключаем нужный lockbox #####
data "yandex_lockbox_secret_version" "mysql" {
  secret_id = var.lockbox_secret_id
}

##### Кластер БД MySQL #####
resource "yandex_mdb_mysql_cluster" "neto_ter_project" {
  name                = var.project_name
  environment         = var.mysql_environment
  network_id          = yandex_vpc_network.project.id
  version             = var.mysql_version
  security_group_ids  = [yandex_vpc_security_group.project.id]
  deletion_protection = false

  resources {
    resource_preset_id = var.mysql_resource_preset_id
    disk_type_id       = var.mysql_disk_type
    disk_size          = var.mysql_disk_size
  }

  host {
    zone      = var.default_zone
    subnet_id = yandex_vpc_subnet.project.id
  }
}


##### БД MySQL #####
resource "yandex_mdb_mysql_database" "neto_ter_project" {
  cluster_id = yandex_mdb_mysql_cluster.neto_ter_project.id
  name       = var.project_name
}


##### Пользователи БД MySQL #####
resource "yandex_mdb_mysql_user" "connect" {
  cluster_id = yandex_mdb_mysql_cluster.neto_ter_project.id
  name       = local.db_user
  password   = local.db_password

  permission {
    database_name = var.project_name
    roles         = ["ALL"]
  }
}


##### Container Registry #####
resource "yandex_container_registry" "neto_ter_project_registry" {
  name      = var.project_name
  folder_id = var.folder_id
}


##### Сборка и push Docker-образа #####
resource "null_resource" "docker_build_push" {
  depends_on = [yandex_container_registry.neto_ter_project_registry]

  provisioner "local-exec" {
    working_dir = "${path.module}/../app"

    command = <<EOT
    docker buildx create --use --name yc-builder || docker buildx use yc-builder
    docker buildx build --platform linux/amd64 \
      -t cr.yandex/${yandex_container_registry.neto_ter_project_registry.id}/fastapi-logger:latest \
      --push .
    EOT
  }
}


##### ВМ для веб-сервера #####
resource "yandex_compute_instance" "web" {
  count       = 1
  name        = "web-${count.index}"
  hostname    = "web-${count.index}"
  zone        = var.default_zone
  platform_id = var.vm_platform
  metadata    = local.metadata_full
  service_account_id = var.sa_id


  resources {
    cores         = var.vm_cpu_core
    memory        = var.vm_ram
    core_fraction = var.vm_cpu_fraction
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    security_group_ids = [
      yandex_vpc_security_group.project.id
    ]
    subnet_id = yandex_vpc_subnet.project.id
    nat       = true
  }
}
