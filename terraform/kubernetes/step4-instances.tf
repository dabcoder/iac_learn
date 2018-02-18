resource "google_compute_instance" "controllers" {
    count           = 3
    name            = "controller${count.index}"
    machine_type    = "n1-standard-1"
    zone            = "${var.region_zone}"
    can_ip_forward  = true

    tags = ["kubernetes-the-hard-way", "controller"]

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-1604-lts"
            size  = "200"
        }
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

    service_account {
        scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
    }

  depends_on = ["google_compute_subnetwork.kubernetes"]
}

resource "google_compute_instance" "workers" {
    count             = 3
    name              = "worker${count.index}"
    machine_type      = "n1-standard-1"
    zone              = "${var.region_zone}"
    can_ip_forward    = true

    tags = ["kubernetes-the-hard-way", "worker"]

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-1604-lts"
            size  = "200"
        }
    }

    network_interface {
        subnetwork  = "kubernetes"
        address     = "10.240.0.2${count.index}"
        access_config {
          # Ephemeral external IP
        }
        alias_ip_range {
            ip_cidr_range = "10.200.${count.index}.0/24"
        }
    }

    metadata {
        ssh-keys = "ubuntu:${file("${var.public_key_path}")}"
    }

    service_account {
        scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
    }

  depends_on = ["google_compute_subnetwork.kubernetes"]
}