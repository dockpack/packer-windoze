
prepare:
	brew bundle
	pip install -r requirements.txt
	ansible-playbook packer-setup.yml -e man_packer_setup_host_type=2012r2 -e opt_packer_setup_packages='["visualcpp-build-tools", "notepadplusplus"]' 

build:
	packer build -force 2012r2/packer.json

box:
	vagrant box add --force jborean93/WindowsServer2012R2 --provider ${VAGRANT_DEFAULT_PROVIDER} 2012r2/virtualbox.box

up:
	vagrant up WindowsServer2012R2

all: prepare build box up

