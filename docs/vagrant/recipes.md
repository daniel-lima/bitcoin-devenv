Recipes
=======

#### Tweak memory usage on Vagrant machines

1\. Create a Vagrantfile.mine anywhere

2\. Change the memory amount for that machine

For example, to give 4G of memory for bitcoin.ubuntu and bitcoin.windows:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  ['ubuntu', 'windows'].each do |shortname|
    name = "bitcoin.#{shortname}"
    
    config.vm.define name do |node|
      
      node.vm.provider 'virtualbox' do |vb|
        vb.memory = '4096'
      end
    end
  end
  
end
```

_Tip_: by adding "vb.cpus = '3'", you can also modify the amount of CPUs/cores dedicated to this machine


3\. Add the file to the load list

    export BOX_OPTS="-l bitcoin/Vagrantfile,dir_of_your_file/Vagrantfile.mine"

4\. Reload the corresponding machine(s)

    vagrant reload /bitcoin.*/
