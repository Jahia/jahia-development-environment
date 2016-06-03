dn: {{ openldap_base }}
objectClass: top
objectClass: dcObject
objectclass: organization
o: Server World
dc: {{ openldap_company }}

dn: cn=Manager,{{ openldap_base }}
objectClass: organizationalRole
cn: Manager
description: Directory Manager

dn: ou=People,{{ openldap_base }}
objectClass: organizationalUnit
ou: People

dn: ou=Group,{{ openldap_base }}
objectClass: organizationalUnit
ou: Group