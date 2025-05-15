data "aws_eks_cluster_auth" "lanchonete_cluster_auth" {
  name = aws_eks_cluster.lanchonete_cluster.name
}

data "aws_iam_role" "labrole" {
  name = "LabRole"
}