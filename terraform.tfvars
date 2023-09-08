skillup_name = "skillup"
knox_id      = "hazel.yap"

region              = "eu-west-1"
vpc_cidr_block      = "10.2.0.0/16"
public_subnet_cidr  = ["10.2.0.0/20", "10.2.16.0/20"]
private_subnet_cidr = ["10.2.128.0/20", "10.2.144.0/20"]
availability_zones  = ["eu-west-1a", "eu-west-1c"]

alb_knox_id    = "hazelyap"
alb_cidr_block = ["203.126.64.67/32", "175.176.24.187/32"]

image_id             = "ami-01e9354a964476532"
instance_type        = "t2.micro"
iam_instance_profile = "skillup-instanceprofile"
keypair              = "skillup-keypair-hazel.yap-001"
user_data            = "user_data.sh"

asg_min_size         = 2
asg_max_size         = 2
asg_desired_capacity = 2

global_tags = {
  GBL_CLASS_0 = "SERVICE"
  GBL_CLASS_1 = "TEST"
}
