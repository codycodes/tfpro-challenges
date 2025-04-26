
variable "environement" {
  type    = number
  default = 1
}

variable "s3_buckets" {
  type    = list(string)
  default = ["bucket-1", "bucket-2"]
}

variable "s3_base_object" {
  default = "myobject"
}

variable "org-name" {
  default = "my-org"
}

variable "region" {
  default = "us-east-1"
}
