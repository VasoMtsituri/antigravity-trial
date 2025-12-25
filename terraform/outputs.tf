output "bucket_name" {
  description = "The name of the bucket."
  value       = module.raw_stock_bucket.name
}

output "bucket_url" {
  description = "The URL of the bucket."
  value       = module.raw_stock_bucket.url
}
