provider "google" {
  region		    = "${var.region}"
  project 		  = "${var.project_name}"
  credentials 	= "${file("${var.credentials_file_path}")}"
}

resource "google_compute_instance" "www" {
  count 		    = 3
  name  		    = "tf-www-${count.index}"
  machine_type  = "f1-micro"
  zone			    = "${var.region_zone}"
  tags			    = ["www-server"]

  disk {
  	image = "ubuntu-1604-xenial-v20170113"
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral external IP
    }
  }

  metadata {
    ssh-keys = "ubuntu:${file("${var.public_key_path}")}"
  }
}

resource "google_compute_firewall" "default" {
  name    = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["www-server"]
}