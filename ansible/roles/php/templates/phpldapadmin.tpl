server {
  # Port that the web server will listen on.
  listen          80;

  # Host that will serve this project.
  server_name     ldap.local;

  # Useful logs for debug.
  error_log /var/log/nginx/error.log;
  access_log /var/log/nginx/access.log;
  rewrite_log     on;

  # The location of our projects public directory.
  root            /usr/share/phpldapadmin/htdocs;

  # Point index to the Laravel front controller.
  index           index.php;

  location / {

    # URLs to attempt, including pretty ones.
    try_files   $uri $uri/ /index.php?$query_string;

  }

  # Remove trailing slash to please routing system.
  if (!-d $request_filename) {
    rewrite     ^/(.+)/$ /$1 permanent;
  }

  # PHP FPM configuration.
    location ~* \.php$ {
    fastcgi_pass                    127.0.0.1:9000;
    fastcgi_index                   index.php;
    fastcgi_split_path_info         ^(.+\.php)(.*)$;
    include                         /etc/nginx/fastcgi_params;
    fastcgi_param                   SCRIPT_FILENAME $document_root$fastcgi_script_name;
  }

  # We don't need .ht files with nginx.
    location ~ /\.ht {
    deny all;
  }

  # Set header expirations on per-project basis
    location ~* \.(?:ico|css|js|jpe?g|JPG|png|svg|woff)$ {
    expires 365d;
  }
}