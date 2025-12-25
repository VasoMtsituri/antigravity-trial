output "bucket_name" {
  description = "The name of the bucket."
  value       = module.raw_stock_bucket.name
}

output "bucket_url" {
  description = "The URL of the bucket."
  value       = module.raw_stock_bucket.url
}

output "composer_environment_url" {
  description = "The URL of the Cloud Composer environment."
  value       = google_composer_environment.composer_env.config[0].airflow_uri
}

output "composer_gcs_bucket" {
  description = "The Cloud Storage bucket used by the environment."
  value       = google_composer_environment.composer_env.config[0].dag_gcs_prefix
}
