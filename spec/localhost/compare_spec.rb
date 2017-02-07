require 'spec_helper'
require 'json'

before_fact = open("spec/localhost/before/centos7_ssh.json") do |io|
  JSON.load(io)
end

after_fact = open("spec/localhost/after/centos7_ssh.json") do |io|
  JSON.load(io)
end

describe command("cat /Serverfact/spec/localhost/after/centos7_ssh.json | jq '.ansible_facts.ansible_local.service_enabled.\"httpd.service\"'") do
  its(:stdout) { should match /#{before_fact['ansible_facts']['ansible_local']['service_enabled']['httpd.service']}/ }
end

describe command("cat /Serverfact/spec/localhost/after/centos7_ssh.json | jq '.ansible_facts.ansible_local.service_enabled.\"sshd.service\"'") do
  its(:stdout) { should match /#{before_fact['ansible_facts']['ansible_local']['service_enabled']['sshd.service']}/ }
end
