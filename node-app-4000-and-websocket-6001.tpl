server {
    listen      %ip%:%proxy_port%;
    server_name %domain_idn% %alias_idn%;
    location / {
        rewrite ^(.*) https://%domain_idn%$1 permanent;
    }

    location /app {
        proxy_pass             http://127.0.0.1:6001;
        proxy_set_header Host  $host;
        proxy_read_timeout     60;
        proxy_connect_timeout  60;
        proxy_redirect         off;

        # Allow the use of websockets
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }


include %home%/%user%/conf/web/*nginx.%domain_idn%.conf_letsencrypt;
}
