server {
  listen          80;
  server_name     {{servername}};
  root            {{tomcat_link}}/webapps/ROOT;
 
  location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://{{host}}:{{ http_port }}/;
        proxy_connect_timeout       1600;
        proxy_send_timeout          1600;
        proxy_read_timeout          1600;
        send_timeout                1600;
  }
}
