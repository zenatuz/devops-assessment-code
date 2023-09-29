#vpc
resource "aws_vpc" "eks" {
  cidr_block = var.cidr_block

  tags = {
    managed-by = "terraform"
    name       = "eks"
  }
}

#subnets
resource "aws_subnet" "eks" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.eks.id
  cidr_block        = element(var.subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Eks Subnet ${count.index + 1}"
  }
}

#routing
resource "aws_internet_gateway" "eks" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "terraform-eks-internet-gateway"
  }
}

resource "aws_route_table" "eks" {
  vpc_id = aws_vpc.eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks.id
  }
}

resource "aws_route_table_association" "eks" {
  count = 2

  subnet_id      = aws_subnet.eks.*.id[count.index]
  route_table_id = aws_route_table.eks.id
}


#security group
resource "aws_security_group" "eks" {
  name        = "eks"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.eks.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks"
  }
}

# security group rule
resource "aws_security_group_rule" "eks-ingress-workstation-https" {
  cidr_blocks       = var.subnet_cidrs
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks.id
  to_port           = 443
  type              = "ingress"
}
