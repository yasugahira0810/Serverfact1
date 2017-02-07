# Serverfact

## Build target host

Refer [this page](https://docs.docker.com/engine/examples/running_ssh_service/)

		docker build -t eg_sshd -f eg_sshd.
		docker run --privileged -it -d -P --name test_sshd eg_sshd

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
- [REDHAT システム管理者のガイド](https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sect-Managing_Services_with_systemd-Services.html)
- [JavaScriptで、もう連想配列の最後のカンマに悩まない！(※追記あり)](http://dqn.sakusakutto.jp/2012/05/javascript-last-comma.html)
- [\[Shell\] bash: コマンドの実行結果を配列や変数に代入する](https://www.d-wood.com/blog/2014/09/23_6869.html)
- [bashの配列変数に関するTips](http://d.hatena.ne.jp/y-kawaz/20100720/1279607344)
