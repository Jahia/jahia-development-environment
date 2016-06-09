# Jahia Vagrant Development Environment #
## Install ##
* Vagrant 1.7.4 - http://www.vagrantup.com/downloads.html
* Virtual Box 5.0.16 - https://www.virtualbox.org/
* Homebrew - http://brew.sh/
* Ansible, `brew install ansible`

## Installed Applications on VM ##
* Digital Factory Enterprise Edition 7.1.2.0
* Marketing Factory 1.0
* Forms Factory 1.1
* Nginx
* Java 8
* Apache Maven 3
* MySQL 5
* OpenLDAP
* Shibboleth IDP
* Mongo

These files will be downloaded on your local environment in the `{{development-environment}}/opt` folder.  This folder can be removed, but any future `vagrant up` will redownload these files to set up your VM.  

## Setting up ##
* `cd {{development-environment}}`
* `git clone git@github.com:Jahia/jahia-development-environment.git`
* Rename `vagrant_config.sample.yml` to `vagrant_config.yml`.  Make any adjustments to the configuration in the vagrant config.
* `vagrant up`

## Host configuration ##
* `sudo vi /etc/hosts`
* Add `192.168.33.99 jahia.local ldap.jahia.local idp.jahia.local`

## Start Jahia ##
* Jahia is set up as a service.
** `service tomcat stop|start|restart|status`

## Navigate ##
### Tomcat ###
* `http://jahia.local:8080/`
* User: `root`
* Password: `root`

### Nginx ###
* `http://jahia.local`
* User: `root`
* Password: `root`

### OpenLDAP ###
* `http://ldap.jahia.local`
* User: `cn=Manager,dc=digitall,dc=com`
* Password: `root`
* Users
* `smomin`/`root`


### Shibboleth IDP ###
* IDP Metadata: `https://idp.jahia.local/idp/shibboleth`, checks to see if IDP returns metadata.
* IDP Status: `https://idp.jahia.local/idp/status`, checks to see if IDP is configured properly.
* Logs: `/opt/shibboleth-idp/logs`, folder where logs are created.
* SAML Authentication Valve, `git@github.com:Jahia/saml-authentication-valve.git`

The IDP is a java webapp deployed in the Jahia tomcat webapps folder.  If any issues hitting the above shibboleth end points, `vagrant ssh` into the environment and execute `sudo service tomcat restart`.

### Mongo ###
* Configurations
* Host: `127.0.0.1`
* Port: `17017`
* DB: `jahiadb`
* Collection: `users`
* Users
* `dpatel@jahia.com`/`password`
* `smomin@jahia.com`/`password`
* `telachkar@jahia.com`/`password`

## Shared Folders
* Create a link or folder `/opt/code` on your local computer.  This path on your local will mirror that path on the virtual environment.  This way any maven commands executed on remote or local with have the correct path to the source code so that Jahia Studio will be able to scan the folders.  Developer can work in the virtual environment by SSH into the box.  If you plan to work in the manner, you can execute `mvn clean install jahia:deploy -P jahia-server`, which will package up the moduleset and deploy it to Digital Factory.

If the steps above execute without any errors, you should now be able to navigate to `http://jahia.local`.

## Switching JDK ##
The default JDK used is 1.8.
####If needed, you can switch the JDK being used by editing config.yml, then modify those three lines :####
* `java_download_url:` provide another download link
* `java_name:`
* `java_archive:`
####After such modifications, you need to apply the new configuration by destroying the machine being runned by Vagrant and recreating it. Do :####
* `vagrant destroy`
* `vagrant up`

## Other things to install ##
### IntelliJ (or another IDE) ###
If you decide to download IntelliJ, download the ultimate version : https://www.jetbrains.com/idea/download/
Then ask Michel Romy a licence. The licence will be imbued to your email, while launching IntelliJ you just have to log in with it.

## Deploy a module on the Virtual Machine ##
### Create a symbolic link ###
* Open vagrant_config.yml and uncomment the line with the parameter `synced_local_folder` and `synced_vagrant_folder`
* Modify this line to map your local folder containing your module(s) to the virtual folder where you wish to find your module(s).
* `vagrant reload`

### Deploy a module ###
* On the virtual machine, navigate to your module's sources (ex: /opt/projectName)
* `mvn clean install jahia:deploy`

### Maven ###
Once Homebrew is installed, you can use it to install easily Maven on your computer using this command : `brew install maven`
It will install Maven, and automatically perform the export command (you can check it using `mvn -version)

### Enhanced terminal with Git support ###
* Download and install iTerm2 : http://iterm2.com/
* Open iTerm2 and change the default shell to Zsh : `chsh -s /bin/zsh`
* Install oh-my-zsh : `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`
* Close your iTerm2 window and open a new one. Navigate to a directory with	a git repository, you should be able to see on which branch you currently are

## Miscellaneous ##
This process will install Jahia Enterprise version, with a trial licence of 30 days.

By default, all will be installed (JDK, Maven, Jahia, ...) in the /opt folder of the virtual box.
