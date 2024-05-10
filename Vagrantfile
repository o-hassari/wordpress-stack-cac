VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # Configuration du box de base
    config.vm.box = "debian/buster64"

    # Création de la VM bastion
    config.vm.define "bastion" do |bastion|
    bastion.vm.hostname = "bastion"
    bastion.vm.network "private_network", ip: "192.168.20.10"
    bastion.vm.provider :virtualbox do |vb|
        vb.name = bastion.vm.hostname
        vb.customize ["modifyvm", :id, "--memory", 1024, "--cpus", 2] #, "--hwvirtex", "on"
    end # end provider
    


    # Provisionnement de la VM bastion
    bastion.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update -y
      sudo apt install -y ansible

      sudo cp  /vagrant/sshkey/id_rsa /vagrant/sshkey/id_rsa.pub /home/vagrant/.ssh/
      sudo chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa
      sudo chmod 600 /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa

    SHELL


  end

  # Création des autres VMs
  (1..2).each do |i|
    config.vm.box = "debian/bullseye64"
    config.vm.define "vm#{i}" do |vm|
        vm.vm.hostname = "vm#{i}"
        vm.vm.network "private_network", ip: "192.168.20.1#{i+1}"
        vm.vm.provider :virtualbox do |vb|
            vb.name = vm.vm.hostname
            vb.customize ["modifyvm", :id, "--memory", 512, "--cpus", 2] #, "--hwvirtex", "on"
        end # end provider
        

      # Provisionnement des autres VMs
      vm.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update -y
        # cp -r /vagrant/sshkey/ ~/.ssh/
        cat /vagrant/sshkey/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys 

      SHELL

    end
  end

  # Création des autres VMs
  (3..4).each do |i|
    config.vm.box = "debian/bullseye64"
    config.vm.define "vm#{i}" do |vm|
        vm.vm.hostname = "vm#{i}"
        vm.vm.network "private_network", ip: "192.168.20.1#{i+1}"
        vm.vm.provider :virtualbox do |vb|
            vb.name = vm.vm.hostname
            vb.customize ["modifyvm", :id, "--memory", 512, "--cpus", 2] #, "--hwvirtex", "on"
        end # end provider
        

      # Provisionnement des autres VMs
      vm.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update -y
        # cp -r /vagrant/sshkey/ ~/.ssh/
        cat /vagrant/sshkey/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys 
        #sudo apt install nginx -y
      SHELL

    end
  end


  # Création des autres VMs
  (5..6).each do |i|
    config.vm.box = "debian/bullseye64"
    config.vm.define "vm#{i}" do |vm|
        vm.vm.hostname = "vm#{i}"
        vm.vm.network "private_network", ip: "192.168.20.1#{i+1}"
        vm.vm.provider :virtualbox do |vb|
            vb.name = vm.vm.hostname
            vb.customize ["modifyvm", :id, "--memory", 512, "--cpus", 2] #, "--hwvirtex", "on"
        end # end provider
        

      # Provisionnement des autres VMs
      vm.vm.provision "shell", inline: <<-SHELL
        sudo apt-get update -y
        # cp -r /vagrant/sshkey/ ~/.ssh/
        cat /vagrant/sshkey/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys 
        
      SHELL

    end
  end


end
