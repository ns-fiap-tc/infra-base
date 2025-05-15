# EKS Cluster
resource "aws_eks_cluster" "lanchonete_cluster" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.labrole.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.lanchonete_public_subnet_1.id,
      aws_subnet.lanchonete_public_subnet_2.id,
      aws_subnet.lanchonete_private_subnet_1.id,
      aws_subnet.lanchonete_private_subnet_2.id
    ]
    
    security_group_ids = [aws_security_group.eks_security_group.id]
  }

  tags = {
    Name = "lanchonete_cluster"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "lanchonete_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "lanchonete_node_group"
  node_role_arn   = data.aws_iam_role.labrole.arn
  subnet_ids      = [
      aws_subnet.lanchonete_public_subnet_1.id,
      aws_subnet.lanchonete_public_subnet_2.id,
      aws_subnet.lanchonete_private_subnet_1.id,
      aws_subnet.lanchonete_private_subnet_2.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  lifecycle {
    prevent_destroy = false
  }

  instance_types = ["t3.medium"]
  disk_size      = 20

  ami_type = "AL2023_x86_64_STANDARD"

  depends_on = [aws_eks_cluster.lanchonete_cluster]
}

# Criação do security Group para o EKS
resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.lanchonete_vpc.id
  name        = "SG-${var.cluster_name}"
  description = "Allow traffic for EKS Cluster (lanchonete)"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
