source "yandex" "debian_docker" {
  token               = file("~/.secrets/packer/yc_oauth_token.txt")
  disk_type           = "network-hdd"
  folder_id           = "b1gtcvs9o26k594vhho4"
  image_description   = "my custom debian with docker"
  image_name          = "debian-12-docker-no-family"
  image_family        = "my-debian"
  source_image_family = "debian-12" 
  subnet_id           = "e9bf5gfea7r1l93c3q56"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
  ssh_username        = "debian"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "echo 'hello from packer'",
      "sudo apt update",
      "sudo apt install -y curl htop tmux",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "docker --version"
      ]
  }

}
