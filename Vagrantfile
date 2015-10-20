# -*- mode: ruby -*-
# vi: set ft=ruby :

#shell this bitch out 

$script = <<SCRIPT

  sudo apt-get update

  echo "!--------------Install packages--------------!" 
  sudo apt-get install -y git build-essential libssl-dev libcurl4-openssl-dev libreadline-dev libsqlite3-dev libpq-dev nodejs
  
  echo "!--------------Install rbenv--------------!"
  git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.profile
  echo 'eval "$(rbenv init -)"' >> $HOME/.profile

  echo "!--------------Install ruby-build--------------!"
  git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

  echo "!--------------Install rbenv-gem-rehash--------------!"
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git $HOME/.rbenv/plugins/rbenv-gem-rehash
  
  echo "!--------------Setup gemrc--------------!"
  echo 'install: --no-document' >> $HOME/.gemrc
  echo 'update: --no-document' >> $HOME/.gemrc

  source $HOME/.profile

  echo "!--------------Install ruby--------------!"
  rbenv install 2.2.3
  rbenv global 2.2.3

  ruby -v

  echo "!--------------Install bundler--------------!"
  gem install bundler

SCRIPT


VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # Use Ubuntu 14.04 Trusty Tahr 64-bit as our operating system
    config.vm.box = "ubuntu/trusty64"
    config.vm.provision "shell", inline: $script, privileged: false
    # Configurate the virtual machine to use 2GB of RAM
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
end
# Forward the Rails server default port to the host
config.vm.network :forwarded_port, guest: 3000, host: 3000

end