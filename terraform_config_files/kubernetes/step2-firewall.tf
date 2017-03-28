resource "google_compute_firewall" "all1" {
	name    = "kubernetes-allow-icmp"
	network = "kubernetes"

	allow {
    	protocol = "icmp"
  	}

  source_ranges = ["0.0.0.0/0"]
  depends_on = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "all2" {
	name    = "kubernetes-allow-rdp"
	network = "kubernetes"

  	allow {
    	protocol = "tcp"
    	ports    = ["3389"]	
  	}

  	source_ranges = ["0.0.0.0/0"]
    depends_on    = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "all3" {
	name 	  = "kubernetes-allow-ssh"
	network = "kubernetes"

  	allow {
  		protocol = "tcp"
  		ports    = ["22"]
  	}

  	source_ranges = ["0.0.0.0/0"]
    depends_on    = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "all4" {
	name 	  = "kubernetes-allow-api-server"
	network = "kubernetes"

  	allow {
  		protocol = "tcp"
  		ports    = ["6443"]
  	}

  	source_ranges = ["0.0.0.0/0"]
    depends_on    = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "internal1" {
	name    = "kubernetes-allow-internal"
	network = "kubernetes"

	allow {
    	protocol = "icmp"
  	}

	allow {
    	protocol = "tcp"
    	ports		 = ["0-65535"]
  	}

  	source_ranges = ["10.240.0.0/24"]
    depends_on    = ["google_compute_network.kubernetes"]
}

resource "google_compute_firewall" "internal2" {
	name 	  = "kubernetes-allow-healthz"
	network = "kubernetes"

	allow {
    	protocol  = "tcp"
    	ports     = ["8080"]
  	}

  	source_ranges = ["130.211.0.0/22"]
    depends_on    = ["google_compute_network.kubernetes"]
}