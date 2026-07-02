terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Artifact Registry Repository
resource "google_artifact_registry_repository" "payment_api" {
  location      = var.region
  repository_id = "payment-api"
  format        = "DOCKER"
  description   = "Payment API Docker repository"
}

# Cloud Run Service
resource "google_cloud_run_v2_service" "payment_api" {
  name     = var.service_name
  location = var.region

  template {
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/payment-api/${var.image_name}:latest"
      
      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }

      env {
        name  = "ENV"
        value = "production"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# Make Cloud Run publicly accessible
resource "google_cloud_run_v2_service_iam_member" "public" {
  location = google_cloud_run_v2_service.payment_api.location
  name     = google_cloud_run_v2_service.payment_api.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
