# aws
variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "cluster_name" {
  type    = string
  default = "static-site-eks"
}

variable "k8s_version" {
  type    = string
  default = "1.28"
}

variable "node_instance_type" {
  type    = string
  default = "t3.small"
}

variable "replica_count" {
  type    = number
  default = 1
}

# helm
variable "image_repository" {
  default = "brandonwen1017/bito-homework"
}
variable "image_tag" {
  default = "latest"
}
variable "ingress_host" {
  default = "static.example.com"
}

# monitoring
variable "slack_webhook_url" {
  type        = string
  description = "Slack Incoming Webhook URL for alerts"
  sensitive   = true
}
