provider "google" {
  project = "${var.gcp_project_id}"
  credentials = "${file("account.json")}"
  version = "2.9.1"
}

provider "null" {
  version = "2.1.2"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "ssh-only" {
  name    = "test-firewall"
  network = "${google_compute_network.vpc_network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "${google_compute_network.vpc_network.self_link}"
    access_config {
      nat_ip = "${google_compute_address.static.address}"
    }
  }

}
