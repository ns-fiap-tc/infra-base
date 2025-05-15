# Output para exibir o ID da VPC criada
output "vpc_id" {
  value       = aws_vpc.lanchonete_vpc.id
  description = "O ID da VPC criada"
}

output "eks_cluster_name" {
  value = aws_eks_cluster.lanchonete_cluster.name
}

output "api_gateway_endpoint" {
  value = "https://${aws_api_gateway_rest_api.lanchonete_cluster_api_gw.id}.execute-api.us-east-1.amazonaws.com"
  #description = "Endpoint HTTPS global do API Gateway para acessar os recursos da API."
}