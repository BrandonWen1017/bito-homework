output "cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "ingress_nginx_lb_hostname" {
  value = helm_release.ingress_nginx.status[0].load_balancer[0].ingress[0].hostname
  description = "若 controller service type=LoadBalancer，此處會有 LB 的 hostname (或 IP)。"
}
