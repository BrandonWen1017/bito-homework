FROM nginx:alpine

# 複製自訂設定檔
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 複製靜態檔案
COPY ./public /usr/share/nginx/html

# Nginx 預設監聽 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
