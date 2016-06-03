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