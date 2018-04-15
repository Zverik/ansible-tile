Vagrant.configure(2) do |config|
  # config.vm.box = "ubuntu/xenial64"
  config.vm.box = "nrclark/xenial64-minimal-libvirt"
  config.vm.host_name = "tile"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.ssh.insert_key = false

  config.vm.provision "ansible" do |ansible|
    ansible.force_remote_user = false
    ansible.vault_password_file = ".vault_pass"
    ansible.verbose = "v"
    ansible.playbook = "playbook.yml"
  end
end
