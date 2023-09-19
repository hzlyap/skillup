resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

#  assign_generated_ipv6_cidr_block = true

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-vpc-${var.knox_id}-001"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.vpc.id

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-igw-${var.knox_id}-001"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${element(var.public_subnet_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

#  assign_ipv6_address_on_creation = true
#  ipv6_cidr_block = "${cidrsubnet(aws_vpc.eu-central-1.ipv6_cidr_block, 8, 1)}"

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-public-subnet-${var.knox_id}-00${count.index+1}"
    }
  )
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

#  route {
#    ipv6_cidr_block = "::/0"
#    gateway_id = aws_internet_gateway.igw.id
#  }

  tags = merge(
    var.global_tags,
      {
        Name = "${var.skillup_name}-public-rtb-${var.knox_id}-001"
      }
  )
}

resource "aws_route_table_association" "public_rta" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id            = aws_vpc.vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-vpce-${var.knox_id}-001"
    }
  )
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${element(var.private_subnet_cidr, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-private-subnet-${var.knox_id}-00${count.index+1}"
    }
  )
}

resource "aws_route_table" "private_rtb" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.vpc.id
  
  tags = merge(
    var.global_tags,
      {
        Name = "${var.skillup_name}-private-rtb-${var.knox_id}-00${count.index+1}"
      }
  )
}

resource "aws_route_table_association" "private_rta" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_rtb.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint_rta" {
  count           = length(var.private_subnet_cidr)
  route_table_id  = "${element(aws_route_table.private_rtb.*.id, count.index)}"
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
}
