echo 'nameserver 192.232.3.1' > /etc/resolv.conf

# Setup
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start

# Copy file nginx default
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

# nginx configuration
echo ' upstream worker {
    server 192.248.1.1;
    server 192.248.1.2;
    server 192.248.1.3;
}

server {
    listen 80;
    server_name harkonen.it31.com www.harkonen.it31.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

# restart nginx
service nginx restart