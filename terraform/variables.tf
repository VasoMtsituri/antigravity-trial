variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "project-6e4dc205-0d7d-44c6-975"
}

variable "region" {
  description = "The region in which to provision resources."
  type        = string
  default     = "us-central1"
}

variable "composer_environment_name" {
  description = "Name of the Cloud Composer environment."
  type        = string
  default     = "aether-composer-env"
}

variable "composer_image_version" {
  description = "The version of the Cloud Composer image to use."
  type        = string
  default     = "composer-3-airflow-2.9.3"
}
