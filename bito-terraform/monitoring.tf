resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true

  values = [
    <<EOF
grafana:
  adminPassword: "admin123"   # 改掉成安全密碼
  service:
    type: LoadBalancer

alertmanager:
  config:
    global:
      resolve_timeout: 5m
    route:
      receiver: "default-receiver"
    receivers:
      - name: "default-receiver"
        slack_configs:
          - send_resolved: true
            channel: "#alerts"
            username: "alertmanager"
            api_url: "${var.slack_webhook_url}"   # 從 variables.tf 傳入
EOF
  ]
}
