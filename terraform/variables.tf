variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "payments-dev-478615"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-south1"
}

variable "service_name" {
  description = "Cloud Run Service Name"
  type        = string
  default     = "payment-api"
}

variable "image_name" {
  description = "Docker Image Name"
  type        = string
  default     = "payment-api"
}
