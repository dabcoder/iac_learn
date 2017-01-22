variable "region" {
	default = "europe-west1"
}

variable "region_zone" {
	default = "europe-west1-b"
}

variable "project_name" {
  	default = "id_of_the_project_on_GCP"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcloud/Terraform.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/gcloud_id_rsa"
}

