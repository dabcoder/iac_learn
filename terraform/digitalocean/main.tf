provider "digitalocean" {
  token = "${var.digital_ocean_token}"
}

resource "digitalocean_ssh_key" "default" {
  name       = "SSH Key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "digitalocean_droplet" "webserver" {
  image              = "${var.image}"
  name               = "webserver"
  region             = "${var.region}"
  size               = "${var.droplet_size}"
  ssh_keys           = ["${digitalocean_ssh_key.default.id}"]

  connection {
    type        = "ssh"
    private_key = "${file("~/.ssh/id_rsa")}"
    user        = "root"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "provision.sh"
    destination = "/tmp/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provision.sh",
      "/tmp/provision.sh args",
    ]
  }
}