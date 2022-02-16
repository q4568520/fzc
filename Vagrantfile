# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
    (1..2).each do |i|
      # config.vm.provision "shell", path: "init.sh"
      config.vm.define "salt#{i}" do |node|
        node.vm.box = "ubuntu/focal64"
        node.ssh.insert_key = false
        node.vm.hostname = "salt#{i}"
        node.vm.network "forwarded_port", guest: 9090, host: "909#{i}", host_ip: "127.0.0.1"
        node.vm.network "private_network", ip: "192.168.56.2#{i}"
        node.vm.synced_folder ".", "/home/vagrant/provision", type: "rsync"
        #   config.vm.synced_folder "./", "/vagrant", type:"virtualbox", :owner => 'apache', :group => 'apache', mount_option: ['dmode=777', 'fmode=755']
        node.vm.provision "shell", path: "init.sh"
        node.vm.provider "virtualbox" do |v|
          v.cpus = 1
          v.customize ["modifyvm", :id, "--name", "salt#{i}", "--memory", "1024"]
        end
      end
    end
end
