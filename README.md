# Serverfact

## Build target host

Refer [this page](https://docs.docker.com/engine/examples/running_ssh_service/)

		docker build -t eg_sshd -f eg_sshd.
		docker run -it -d -P --name test_sshd eg_sshd

## Write hosts file

		[test-server]
		192.168.11.2:32770 ansible_ssh_pass=screencast ansible_ssh_user=root

## Gathering fact

		# Previous arrangement
		ssh 192.168.225.22 -p 32771

		# Execute Ansible
		ansible test-server -i hosts -m setup

## Verify test-server

		# Previous arrangement
		cat ~/.ssh/config
		Host 192.168.225.22
		  HostName 192.168.225.22
		  Port 32771
		  User root

		# Execute Serverspec
		rake spec:192.168.225.22

## List Services

		# CentOS7
		systemctl list-unit-files

## Settle ansible_local file

		# /etc/ansible/facts.d/service.fact 
		#!/bin/sh
		
		SERVICE=`systemctl list-unit-files | tr "\n" " "`
		cat <<EOF
		{
		  "service" : "$SERVICE"
		}
		EOF

## Reference

- [Ansibleを支えるfact: プラットフォームの情報を取得](http://tdoc.info/blog/2013/08/23/ansible_fact.html)
