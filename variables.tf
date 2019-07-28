variable "profile_name" {
  description = "AWS Cli profile"
  default     = "default"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Domain name"
  default     = "api.skynetng.pw"
}

variable "log_retention_in_days" {
  description = "Log retention in days"
  default     = 7
}

variable "function_name" {
  description = "Function name"
  default     = "mylambda"
}

variable "stage_name" {
  description = "Api version number"
  default     = "v1"
}

variable "environment_variables" {
  description = "Map with environment variables for the function"

  default = {
    myenvvar = "test"
  }
}
