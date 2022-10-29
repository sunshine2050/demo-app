variable "db_pass" {
  type        = string
  description = "SQL Server db pass"
}

variable "db_user" {
  type        = string
  description = "SQL Server db user"
}

variable "image_build" {
  type        = string
  description = "Docker Image tag"
}