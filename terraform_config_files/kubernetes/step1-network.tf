provider "google" {
  	region          = "${var.region}"
  	project         = "${var.project_name}"
  	credentials     = "${file("${var.credentials_file_path}")}"
}

resource "google_compute_network" "kubernetes" {
	name                    = "kubernetes"
	auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "kubernetes" {
	name            = "kubernetes"
	ip_cidr_range   = "10.240.0.0/24"
	network         = "kubernetes"
	depends_on      = ["google_compute_network.kubernetes"]
}