dn: olcDatabase={0}config,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {{ generated_root_password.stdout }}