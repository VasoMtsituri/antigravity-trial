variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "name" {
  description = "The name of the bucket."
  type        = string
}

variable "location" {
  description = "The location of the bucket."
  type        = string
  default     = "US"
}

variable "storage_class" {
  description = "The Storage Class of the new bucket."
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects."
  type        = bool
  default     = false
}

variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket."
  type        = bool
  default     = false
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = {}
}
