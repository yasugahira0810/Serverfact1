# Serverfact

## Build target host

Refer [this page](https://docs.docker.com/engine/examples/running_ssh_service/)

		docker build -f centos7_ssh -t centos7_ssh .
		docker run --privileged -it -d -P --name centos7_ssh centos7_ssh

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

## Exec playbook

		ansible-playbook centos7_ssh.yml -i hosts

実行対象をhostsファイルで限定する方法がわからない。  
下記でcentos6_sshの記載があると、centos7_sshに実行したいのに  
centos6_sshに実行してしまう。仕方ないので、コメントアウト。

		#[centos6_ssh]
		#192.168.225.22:32776
		
		[centos7_ssh]
		192.168.225.22:32777
		
		[all:vars]
		ansible_ssh_pass=password
		ansible_ssh_user=root



## jqインストール

		curl -o /usr/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x /usr/bin/jq

## jq1によるキー取得（未完）

		cat localhost/before/centos7_ssh.json | jq '.ansible_facts.ansible_local.service_enabled."httpd.service"'

## Reference

- [Ansibleを支えるfact: プラットフォームの情報を取得](http://tdoc.info/blog/2013/08/23/ansible_fact.html)
- [REDHAT システム管理者のガイド](https://access.redhat.com/documentation/ja-JP/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/sect-Managing_Services_with_systemd-Services.html)
- [JavaScriptで、もう連想配列の最後のカンマに悩まない！(※追記あり)](http://dqn.sakusakutto.jp/2012/05/javascript-last-comma.html)
- [\[Shell\] bash: コマンドの実行結果を配列や変数に代入する](https://www.d-wood.com/blog/2014/09/23_6869.html)
- [bashの配列変数に関するTips](http://d.hatena.ne.jp/y-kawaz/20100720/1279607344)
- [json出力する際に、キーの名前も一緒に表示したい](https://teratail.com/questions/51006)
- [bashのシェルスクリプトの記述に関してメモ等](http://qiita.com/dskshmz/items/c01f29f8398cc7f5c396)
