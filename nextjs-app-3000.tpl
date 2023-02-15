server {
    listen      %ip%:%proxy_port%;
    server_name %domain_idn% %alias_idn%;
    error_log  /var/log/%web_system%/domains/%domain%.error.log error;

    root %sdocroot%/nodeapp/public;
    # index index.html;

    location / {
        proxy_pass      http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
  include %home%/%user%/conf/web/*nginx.%domain_idn%.conf_letsencrypt;
}

