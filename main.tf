# Create the default VPC based on the variable
resource "google_compute_network" "default_vpc" {
  # Only create if the variable is set to true
  count                   = var.create_default_vpc ? 1 : 0
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = true
  description             = "Default VPC network"
  
  # This makes Terraform ignore errors if the VPC already exists
  lifecycle {
    ignore_changes = all
  }
}

# Create a firewall rule for SSH access
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.vpc_name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges
  target_tags   = ["allow-ssh"]
  
  # Ensure the network exists before creating the firewall rule
  depends_on = [google_compute_network.default_vpc]
}

# Create the VM instance using the default VPC
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = var.disk_size
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }
  
  # Shielded VM configuration
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  
  # Optional: Add labels for better resource management
  labels = {
    customer = var.customer_name
  }
  tags = ["allow-ssh"]

  # Add dependency to ensure VPC exists before VM creation
  depends_on = [google_compute_network.default_vpc]
}