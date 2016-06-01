dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=Manager,{{ openldap_base }}" read by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: {{ openldap_base }}

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,{{ openldap_base }}

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {{ generated_manger_password.stdout }}

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by dn="cn=Manager,{{ openldap_base }}" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=Manager,{{ openldap_base }}" write by * read

dn: cn=Sajid Momin,ou=People,{{ openldap_base }}
cn: Sajid Momin
givenname: Sajid
homephone: 5127854878
homepostaladdress: 555 4th St
initials: A
mail: smomin@jahia.com
objectclass: inetOrgPerson
objectclass: top
ou: people
postalcode: 94107
sn: Momin
st: CA
street: 555 4th St
telephonenumber: 5127854878
uid: smomin
userpassword: root

dn: cn=Registered Users,ou=Group,{{ openldap_base }}
cn: Registered Users
objectclass: groupOfUniqueNames
objectclass: top
uniquemember: cn=Sajid Momin,ou=People,{{ openldap_base }}