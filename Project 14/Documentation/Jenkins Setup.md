#### Creating a VM Using Vagrant
This Jenkins setup was done in a VM created using Vagrant. The VM is running Ubuntu 18.04 and has some changes from the Jekins setup.

1. Download Ubuntu 18.04 box from the website: https://app.vagrantup.com/ubuntu/boxes/bionic64
2. Run the following:
```
vagrant init ubuntu/bionic64
```

3. Modify the Vagrantfile with the following:
```
    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu18.04"
    config.vm.network "forwarded_port", guest: 8080, host: 8080

    config.vm.provider "virtualbox" do |vb|
        vb.name = "VM for Testing"
        vb.gui = false
        vb.memory = "4096"
        vb.cpus = 2
    end

    config.vm.provision "shell", inline: <<-SHELL
        apt-get update -y
        apt-get upgrade -y
        wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
        deb https://pkg.jenkins.io/debian binary/
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
        apt-get update
        apt-get install openjdk-8-jdk jenkins maven google-chrome-stable firefox
    SHELL
    end
```

4. Run the following command to start the VM:
```
    vagrant up
```

5. Run the following commands to prepare and package the new VM created using the Vagrantfile:
```
    # On the host machine enter this command:
    vagrant ssh

    # On the VM enter these commands:
    # Clean the apt cache
    sudo apt-get clean
    sudo dd if=/dev/zero of=/EMPTY bs=1M
    sudo rm -f /EMPTY
    cat /dev/null > ~/.bash_history && history -c && exit

    # On the hostt machine enter these commands:
    vagrant package --output ubuntu18.04.box
    vagrant box add ubuntu18.04 ubuntu18.04.box

    vagrant destroy
    rm Vagrantfile

    vagrant init ubuntu18.04
```

6. Modify the Vagrant file however way you wish then run 
```
vagrant up
```

#### Setting up Jenkins
With the VM running from the first section, do the following to setup Jenkins
1. On your host machine, go to localhost:8080
2. On your VM use the cat command to find the security key.
3. Enter the security key into the browser of your host machine. 
4. Select the default packages. 
5. Create a new admin account.
6. If at this point, you get a blank screen, restart your Jenkins service.
```
    sudo service jenkins stop
    sudo service jenkins start
```
7. Login to Jenkins Dashboard with your admin account.
8. Go to Manage Jenkins > Manage Plugins > Available. Then select Maven Integration. Finally Select Download now and install after restart.
9. Go to Global Tool Configuration > JDK installations > and set JAVA_HOME to /usr/lib/jvm/java-1.8.0-openjdk-amd64/
10. In Global Tool Configuration > Maven > and set MAVEN_HOME to /usr/share/maven


#### Important Notes: 
1. Browsers need to be installed on the Linux machine running Jenkins in order for tests not to fail with the result: "unknown error: cannot find Chrome binary"
2. Even with a browser installed the tests can fail with the reason: "unknown error: Chrome failed to start: exited abnormally" The way to fix this is in one of two ways:
    1. Change the code to include the following lines:
        ```
            ChromeOptions chromeOptions = new ChromeOptions();
            chromeOptions.addArguments("--headless", "--no-sandbox");
            WebDriver driver = new ChromeDriver(chromeOptions); 
        ```
    2. Use DesiredCapabilities.

#### Setting up a Maven job
1. Select New Item
2. Give a name and select Maven project. 
3. Give a description and GitHub project url.
4. In Source Code Management, select Git.
5. Add the credentials required for this step.
6. In Build > Goals and options > validate clean test
7. Save and then Select Build Now.