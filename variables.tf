variable "owner_email" {
    type = string
}

variable "aws_region" {
    type = string
    default = "us-east-2"
}

variable "instance_types" {
    type = list(string)
    default = ["m5.large"]
}

variable "kubernetes_version" { 
    type = string
    default = "1.23"
}

variable "cluster_name" {
    type = string
    default = "k8s-cluster"
}