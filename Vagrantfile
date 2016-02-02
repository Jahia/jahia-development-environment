VAGRANTFILE_API_VERSION = "2"

require 'yaml'
vconfig = YAML::load_file("vagrant_config.yml")

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
# source: https://stackoverflow.com/questions/2108727/which-in-ruby-checking-if-program-exists-in-path-from-ruby
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.provider :virtualbox do |v|
        v.name = vconfig['config']['name']
        v.customize [
            "modifyvm", :id,
            "--name", vconfig['config']['name'],
            "--memory", vconfig['config']['memory'],
        ]
    end

    # Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = vconfig['config']['box']
	config.vm.box_url = vconfig['config']['box_url']
    
	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	# config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 80, host: 9000, auto_correct: true
	config.vm.network "forwarded_port", guest: 8080, host: 9080, auto_correct: true
	config.vm.network "forwarded_port", guest: 8181, host: 8181, auto_correct: true
	config.vm.network "forwarded_port", guest: 8000, host: 9999, auto_correct: true
	config.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true

    config.vm.network :private_network, ip: vconfig['config']['ip']
    config.ssh.forward_agent = true
    config.vbguest.auto_update = true

	# config.vm.synched_folder "/path/to/local/app" "/path/vagrant/folder"
	# i.e config.vm.synced_folder "/Users/jahia/Documents/projects/jahia/tests", "/opt/tests"
	if !vconfig['config']['synced_local_folder'].nil? && !vconfig['config']['synced_vagrant_folder'].nil?
	    config.vm.synced_folder vconfig['config']['synced_local_folder'], vconfig['config']['synced_vagrant_folder']
    end
    # Mapping my local .m2 folder so the VM does not have to download dependencies.
    config.vm.synced_folder "~/.m2", "/home/vagrant/.m2"
    config.vm.synced_folder "~/.m2", "/root/.m2"
    #############################################################
    # Ansible provisioning (you need to have ansible installed)
    #############################################################

    
    if which('ansible-playbook')
        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "ansible/playbook.yml"
            ansible.inventory_path = "ansible/inventories/dev"
            ansible.limit = 'all'
            ansible.extra_vars = {
                private_interface: vconfig['config']['ip'],
                hostname: vconfig['config']['name']
            }
        end
    else
        config.vm.provision :shell, path: "ansible/windows.sh", args: ["default"]
    end
end
