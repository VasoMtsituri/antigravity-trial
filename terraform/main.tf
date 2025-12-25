provider "google" {
  project = "project-6e4dc205-0d7d-44c6-975"
  region  = "us-central1"
}

module "raw_stock_bucket" {
  source = "./modules/gcs"

  name          = "aether-raw-stock-data-project-6e4dc205-0d7d-44c6-975"
  project_id    = "project-6e4dc205-0d7d-44c6-975"
  location      = "US"
  storage_class = "STANDARD"
  versioning    = true
  force_destroy = false
}
