1. Docker
   Dockerhub url: https://hub.docker.com/r/brandonwen1017/bito-homework/tags
   ### 包檔
   docker build -t brandon-bito-homework:latest .
   ### 啟動
   docker run --rm -d -p 8080:80 brandon-bito-homework:latest

2. Helm-chart
   ### 安裝
   helm install bito ./bito-helm
   ### 更新設定（例如修改 values.yaml）
   helm upgrade bito ./bito-helm
   ### 移除
   helm uninstall bito-helm

3. Terraform
   

