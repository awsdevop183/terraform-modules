module "vpc" {
    source = "git::https://github.com/awsdevop183/terraform-modules.git//vpc?ref=v1.0.1"
    vpc-cidr = "172.16.0.0/16"
    vpc-tags = "prod"
    public-cidr = ["172.16.1.0/24","172.16.2.0/24"]
    private-cidr = ["172.16.10.0/24","172.16.20.0/24"]
    vpc-name = "prod"
    instance-type = "t2.medium"
    ami = "ami-0b6c6ebed2801a5cb"
  
}
module "vms" {
    source = "git::https://github.com/awsdevop183/terraform-modules.git//instances?ref=v1.0.1"
    instance-type = "t3.medium"
    ami = "ami-0b6c6ebed2801a5cb"
    key-name = "prod-key"
    vpc-name = "prod"
    sg= "${module.vpc.sg}"
    subnet_id = module.vpc.subnet-id
  
}