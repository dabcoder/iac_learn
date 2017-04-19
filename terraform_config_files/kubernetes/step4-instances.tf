resource "google_compute_instance" "controllers" {
	count           = 3
	name            = "controller${count.index}"
	machine_type    = "n1-standard-1"
	zone            = "${var.region_zone}"
	can_ip_forward  = true

	disk {
		image   = "ubuntu-1604-xenial-v20170307"
		size    = "200"
	}

	network_interface {
		subnetwork  = "kubernetes"
		address     = "10.240.0.1${count.index}"
		access_config {
		  # Ephemeral external IP
		}
	}

	metadata {
		ssh-keys = "ubuntu:${file("${var.public_key_path}")}"
	}

  depends_on = ["google_compute_subnetwork.kubernetes"]
}

resource "google_compute_instance" "workers" {
  count             = 3
  name              = "worker${count.index}"
  machine_type      = "n1-standard-1"
  zone              = "${var.region_zone}"
  can_ip_forward    = true

  	disk {
		image   = "ubuntu-1604-xenial-v20170307"
		size    = "200"
	}

	network_interface {
		subnetwork  = "kubernetes"
		address     = "10.240.0.2${count.index}"
		access_config {
		  # Ephemeral external IP
		}
	}

	metadata {
		ssh-keys = "ubuntu:${file("${var.public_key_path}")}"
	}


  depends_on = ["google_compute_subnetwork.kubernetes"]
}