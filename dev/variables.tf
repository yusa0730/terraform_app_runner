variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "terraform-lead-test"
}

variable "env" {
  description = "The environment (e.g. dev, prod)."
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The AWS region."
  type        = string
  default     = "ap-northeast-1"
}

variable "lambda_function_name" {
  description = "aws_lambda_functionのfunction_nameの値"
  type        = string
  default     = "example_lambda"
}
