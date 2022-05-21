variable "database_name" {
  description = "Name of the database to create"
  type        = string
}

variable "name" {
  description = "The name for the cloud sql instance"
  type        = string
}

variable "region" {
  description = "The region to make the cloud sql instance in"
  type        = string
}