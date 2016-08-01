# in the 'http' block
upstream tomcat {
  ip_hash;
  server {{host}}:{{ http_port }};
}

server {
  listen          80;
  listen          443;
  server_name     {{servername}};
  root            {{tomcat_link}}/webapps/ROOT;

  client_max_body_size 500M;

  ssl on;
  ssl_certificate {{ shibboleth_install }}/credentials/idp-encryption.crt;
  ssl_certificate_key {{ shibboleth_install }}/credentials/idp-encryption.key;

  location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://tomcat;
        proxy_connect_timeout       1600;
        proxy_send_timeout          1600;
        proxy_read_timeout          1600;
        send_timeout                1600;
  }

  # logging
  error_log /var/log/nginx/error.log;
  access_log /var/log/nginx/access.log;
}