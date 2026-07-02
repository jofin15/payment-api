output "service_url" {
  description = "Cloud Run Service URL"
  value       = google_cloud_run_v2_service.payment_api.uri
}

output "artifact_registry_url" {
  description = "Artifact Registry URL"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/payment-api"
}
