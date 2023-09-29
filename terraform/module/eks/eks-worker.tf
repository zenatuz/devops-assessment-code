#Worker Nodes

# Security Group
resource "aws_security_group" "eks_worker" {
  name        = "eks_worker"
  description = "Security group for the nodes in the cluster"
  vpc_id      = aws_vpc.eks.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks_worker_nodes"
  }
}

resource "aws_security_group_rule" "eks_worker_ingress_self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_worker.id
  source_security_group_id = aws_security_group.eks_worker.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_worker_ingress_cluster_https" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker.id
  source_security_group_id = aws_security_group.eks.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks_worker_ingress_cluster_others" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker.id
  source_security_group_id = aws_security_group.eks.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_ingress_node_https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks.id
  source_security_group_id = aws_security_group.eks_worker.id
  to_port                  = 443
  type                     = "ingress"
}

#Policy for the nodes
# data "aws_iam_policy_document" "eks_worker_nodes" {
#   statement {
#     sid     = ""
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_role" "eks_worker_nodes" {
#   name               = "eks_worker_nodes"
#   assume_role_policy = data.aws_iam_policy_document.eks_worker_nodes.json
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks_worker_nodes.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.eks_worker_nodes.name
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.eks_worker_nodes.name
# }

# resource "aws_eks_node_group" "workers" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = "workers"
#   node_role_arn   = aws_iam_role.eks_worker_nodes.arn
#   subnet_ids      = aws_subnet.eks[*].id
#   instance_types  = ["t3.medium"]

#   scaling_config {
#     desired_size = 1
#     max_size     = 2
#     min_size     = 1
#   }

#   update_config {
#     max_unavailable = 1
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
#   ]
# }
