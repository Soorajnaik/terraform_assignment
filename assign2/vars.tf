variable "AWS_REGION" {
    default = "ap-southeast-1"
}
variable "AWS_ACCESSKEY" {
    default = "AKIA43IUG4BEDVG4PXNG"
}
variable "AWS_SECRETKEY" {
    default = "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"
}
variable "AMI" {
    type = map

    default = {
        ap-southeast-1 = "ami-055d15d9cfddf7bd3"
    }
}
