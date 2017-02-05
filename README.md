# Serverfact

## Build target host

Refer [this page](https://docs.docker.com/engine/examples/running_ssh_service/)

		docker build -t eg_sshd -f eg_sshd.
		docker run -it -d -P --name test_sshd eg_sshd

## Write hosts file

		[test-server]
		192.168.11.2:32770 ansible_ssh_pass=screencast ansible_ssh_user=root

## Execute ansible

		ansible test-server -i hosts -m ping
