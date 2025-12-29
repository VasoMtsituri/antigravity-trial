provider "google" {
  project = var.project_id
  region  = var.region
}

module "raw_stock_bucket" {
  source = "./modules/gcs"

  name          = "aether-raw-stock-data-${var.project_id}"
  project_id    = var.project_id
  location      = "US"
  storage_class = "STANDARD"
  versioning    = true
  force_destroy = false
}

resource "google_service_account" "composer_sa" {
  account_id   = "composer-env-sa"
  display_name = "Cloud Composer Service Account"
}

resource "google_project_iam_member" "composer_worker" {
  project = var.project_id
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

resource "time_sleep" "wait_for_iam" {
  depends_on = [google_project_iam_member.composer_worker]

  create_duration = "120s"
}

resource "google_composer_environment" "composer_env" {
  name       = var.composer_environment_name
  region     = var.region
  project    = var.project_id
  depends_on = [time_sleep.wait_for_iam]

  config {
    node_config {
      service_account = google_service_account.composer_sa.email
    }

    software_config {
      image_version = var.composer_image_version
      pypi_packages = {
        "astronomer-cosmos"                  = "==1.12.0"
        "dbt-snowflake"                      = "==1.11.0"
        "apache-airflow-providers-snowflake" = "==5.6.0"
      }
    }
  }
}
