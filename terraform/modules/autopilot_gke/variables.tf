variable "project" {
  description = "Project name to create resource in"
  type        = string
}

variable "region" {
  description = "Region where the resources will be created"
  type        = string
}

variable "name" {
  description = "Name of the gke cluster"
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "subnet_name" {
  description = "The list of subnets to be created"
  type        = string
}

variable "start_time" {
  description = "The start time of the maintenance window"
  default     = "02:00"
}

variable "release_channel" {
  description = "The release channel the gke cluster should use"
  default     = "REGULAR"
}