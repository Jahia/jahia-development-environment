server {
  listen          443;
  server_name     idp.jahia.local;
  root            {{tomcat_link}}/webapps/idp;

  ssl on;
  ssl_certificate {{ shibboleth_install }}/credentials/idp-encryption.crt;
  ssl_certificate_key {{ shibboleth_install }}/credentials/idp-encryption.key;

  location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass https://{{host}}:{{ https_port }}/;
        proxy_connect_timeout       1600;
        proxy_send_timeout          1600;
        proxy_read_timeout          1600;
        send_timeout                1600;
  }

  # logging
  error_log /var/log/nginx/error.log;
  access_log /var/log/nginx/access.log;
}