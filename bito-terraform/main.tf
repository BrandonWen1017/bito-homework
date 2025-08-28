# 使用 terraform-aws-modules/eks/aws 建立 EKS（含 VPC & node groups）
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0" # 你可以更新版本

  cluster_name    = var.cluster_name
  cluster_version = var.k8s_version
  subnets         = null # module 會自動建立 VPC/子網，除非你傳入既有 subnets
  vpc_id          = null

  # 簡單的 managed node group（請視需求調整 instance_type/size）
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = [var.node_instance_type]
    }
  }

  manage_aws_auth = true
  # 若你需要 IAM Role for ServiceAccounts (IRSA)，可在此加入參數
}
