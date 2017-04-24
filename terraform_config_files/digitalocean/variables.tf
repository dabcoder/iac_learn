variable "digital_ocean_token" {
  description = "Digital Ocean token"
}

variable region {
  description = "Region"
  default     = "fra1"
}

variable image {
  description = "Name of the image to use"
  default     = "ubuntu-16-04-x64"
}

variable droplet_size {
  description = "Size of the droplets"
  default     = "1gb"
}