#!/bin/bash

# Nginx SSL configuration
cat <<EOF > /root/AUTcyberscient23B/conf.d/default.conf
server {
    listen 443 ssl http2;
    server_name kiwibytesolutions.info;
    root /public_html/;

    ssl on;
    server_tokens off;
    ssl_certificate /etc/nginx/ssl/live/kiwibytesolutions.info/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/live/kiwibytesolutions.info/privkey.pem;
    ssl_dhparam /etc/nginx/dhparam/dhparam-2048.pem;
    
    ssl_buffer_size 8k;
    ssl_protocols TLSv1.2 TLSv1.1 TLSv1;
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

    location / {
        index index.html;
    }
}
EOF

# Restart Nginx
docker-compose restart web