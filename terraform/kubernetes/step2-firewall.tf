resource "google_compute_firewall" "external" {
    name    = "kubernetes-allow-external"
    network = "kubernetes-the-hard-way"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["22", "3389", "6443"]
    }

    source_ranges = ["0.0.0.0/0"]
    depends_on = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "internal" {
    name    = "kubernetes-allow-internal"
    network = "kubernetes-the-hard-way"

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
    }

    allow {
        protocol = "udp"
    }

    source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
    depends_on    = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "healthz" {
    name    = "kubernetes-allow-healthz"
    network = "kubernetes-the-hard-way"

    allow {
        protocol  = "tcp"
        ports     = ["8080"]
    }

    source_ranges = ["130.211.0.0/22"]
    depends_on    = ["google_compute_network.kubernetes"]
}