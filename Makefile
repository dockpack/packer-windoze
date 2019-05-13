
prepare:
	brew bundle
	pip install -r requirements.txt
	ansible-playbook packer-setup.yml -e man_packer_setup_host_type=2012r2 -e opt_packer_setup_packages='["visualcpp-build-tools", "notepadplusplus"]' 

lint:
	packer validate 2012r2/packer.json
	vagrant validate Vagrantfile
	ansible-lint packer-setup.yml main.yml 
	# jborean93/packer-windoze/issues/25
	# jborean93/ansible-role-win_openssh/issues/2

build:
	packer build -force 2012r2/packer.json

box:
	vagrant box add --force jborean93/WindowsServer2012R2 --provider ${VAGRANT_DEFAULT_PROVIDER} 2012r2/virtualbox.box

up:
	vagrant up WindowsServer2012R2

all: prepare build box up

clean:
	vagrant halt WindowsServer2012R2
	vagrant destroy -f WindowsServer2012R2
	vagrant box remove jborean93/WindowsServer2012R2
	rm -f 2012r2/virtualbox.box
