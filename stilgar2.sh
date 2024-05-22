service nginx start

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php

mkdir /etc/nginx/supersecret
htpasswd -c -b /etc/nginx/supersecret/.htpasswd secmart kcksit31

echo '
    upstream worker { # (ip_hash, least_conn, hash $request_uri consistent)
    server 192.232.1.1;
    server 192.232.1.1;
    server 192.232.1.2;
}
    upstream roundrobin_worker {
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream leastconn_worker {
        least_conn;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream weightedrr_worker {
        server 192.232.1.1 weight=3;
        server 192.232.1.2 weight=2;
        server 192.232.1.3 weight=1;
}

    upstream iphash_worker {
        ip_hash;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

    upstream hash_worker {
        hash $request_uri consistent;
        server 192.232.1.1;
        server 192.232.1.2;
        server 192.232.1.3;
}

server {
    listen 80;
    server_name harkonen.it31.com www.harkonen.it31.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
    }
    location /roundrobin {
        proxy_pass http://roundrobin_worker;
    }
    location /leastconn {
        proxy_pass http://leastconn_worker;
    }
    location /weightedrr {
        proxy_pass http://weightedrr_worker;
    }
    location /iphash {
        proxy_pass http://iphash_worker;
    }
    location /hash {
        proxy_pass http://hash_worker;
    }
}

 server {
	listen 80;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;

	server_name _;

        location / {
                allow 192.232.1.27;
                allow 192.232.1.67;
                allow 192.232.2.203;
                allow 192.232.2.207;
                deny all;
                proxy_pass http://worker;
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/supersecret/.htpasswd;
        }

	location /dune {
		proxy_pass https://www.dunemovie.com.au/;
		proxy_set_header Host www.dunemovie.com.au;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
        }
} ' > /etc/nginx/sites-available/lb_php

ln -sf /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/

if [ -f /etc/nginx/sites-enabled/default ]; then
    rm /etc/nginx/sites-enabled/default
fi

service nginx restart