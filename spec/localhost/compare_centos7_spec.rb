require 'spec_helper'
require 'json'

before_fact = open("spec/localhost/before/centos7_ssh.json") do |io|
  JSON.load(io)
end

after_fact = open("spec/localhost/after/centos7_ssh.json") do |io|
  JSON.load(io)
end


after_fact['ansible_facts']['ansible_local']['service_enabled'].each do |service|
  describe command("echo #{service}") do
    its(:stdout) { should match /#{before_fact['ansible_facts']['ansible_local']['service_enabled']["#{service[0]}"]}/ }
  end
end
