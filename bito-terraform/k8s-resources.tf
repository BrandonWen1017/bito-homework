# 取得 cluster 資訊（跟之前一樣）
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

# 1) 先安裝 ingress-nginx controller
resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true

  values = [
    <<EOF
controller:
  service:
    type: LoadBalancer
EOF
  ]
}

# 2) 部署我們剛剛寫的 static-site Helm Chart
resource "helm_release" "static_site" {
  name       = "static-site"
  chart      = "./k8s/helm-chart"   # 本地 Helm Chart 路徑
  namespace  = "bito"

  values = [
    <<EOF
replicaCount: 1

image:
  repository: "${var.image_repository}"
  tag: "${var.image_tag}"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  className: "nginx"
  host: "${var.ingress_host}"
EOF
  ]
}
