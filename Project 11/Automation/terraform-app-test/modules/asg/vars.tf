variable "alb_target_group_arn" {
}
variable "subnets" {
    default = ["Main","PS1","PS2"]
}
variable "linux_security_group" {
    default = []
}