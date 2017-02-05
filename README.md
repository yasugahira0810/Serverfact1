# Serverfact

## Build target host

Refer [this page](https://docs.docker.com/engine/examples/running_ssh_service/)

## Write hosts file

		[test-server]
		192.168.11.2:32770 ansible_ssh_pass=screencast ansible_ssh_user=root
