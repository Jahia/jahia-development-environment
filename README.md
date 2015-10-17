# Jahia Vagrant Development Environment #
## Install ##
* Vagrant 1.7.4 - http://www.vagrantup.com/downloads.html
* Virtual Box 5.0.2 - https://www.virtualbox.org/
* Homebrew - http://brew.sh/
* Ansible, `brew install ansible`

## Installed Applications on VM ##
* Digital Factory Enterprise Edition 7
* Nginx
* Java 8
* Apache Maven 3
* MySQL 5

## Downloaded Application ##
* Digital Factory Enterprise Edition 7
* Nginx
* Jave 8
* Apache Maven 3
* MySQL 5

These files will be downloaded on your local environment in the `{{development-environment}}/opt` folder.  This folder can be removed, but any future `vagrant up` will redownload these files to set up your VM.  

## Setting up ##
* `cd {{development-environment}}`
* `git clone https://bitbucket.org/sajidmomin/jahia-development-environment.git`
* `vagrant up`

## Host configuration ##
* `sudo vi /etc/hosts`
* Add `192.168.33.99 jahia.local`

## Start Jahia ##
* Jahia is set up as a service.
** `service tomcat stop|start|restart|status`

## Navigate ##
### Tomcat ###
* `http://jahia.local:8080/`

### Nginx ###
* `http://jahia.local`

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
