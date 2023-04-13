resource "google_storage_bucket" "dareit-tf-8" {
  name     = "dareit-tf-8"
  location = "us-central1"
}

# resource "google_storage_default_object_access_control" "website_read" {
#   bucket = google_storage_bucket.website.name
#   role   = "READER"
#   entity = "allUsers"
# }

resource "google_compute_instance" "dareit-vm" {
  name         = "dareit-vm-8"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_storage_bucket" "static-site" {
  name          = "static-website-task8"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_object" "static-site" {
  name   = "index.html"
  source = "website/index.html"
  bucket = google_storage_bucket.static-site.name
}

resource "google_storage_bucket_object" "picture" {
  name   = "cats.jpg"
  source = "website/cats.jpg"
  bucket = google_storage_bucket.static-site.name
}