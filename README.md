Camp Teststand 2013
===================

### Clabash/Cucumber and physical rotation test steps ###

To start the cucumber test you need to set the configuration for the arduino via environment variables.

Example from shell:

	`SERVO_SERVER_ADR="192.168.200.116" SERVO_SERVER_PORT="8080" SERVO_SERVER_DEVICE="2" cucumber`
  
Then you can use the following steps in the tests:

	`I rotate the device to (landscape|portrait)`

### System prerequisites ###

Create a user *jenkins* via Mac OS User configuration and log in with the user *jenkins*.

### Calabash Setup ###

Calabash requires Ruby 1.8.7. Anyhow, some Calabash step definitions may not work (e.g. the  iOS DataPicker step defs) and additional step defs are required. The step defs we found to control the DataPicker require a newer Ruby version (most certainly 1.9.3).
To update your ruby version, install RVM (Ruby Version Manager) by executing 

`curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3`

You may also google for other installation options ;).

Calabash is installed via gem, `gem install calabash-cucumber`.

### Jenkins Setup ###

Jenkins must be run under a common MacOs user. This is mandatory as building an iOS app requires UI access rights.

#### Installation ####

Use the common Mac OS Jenkins installer for installation. Some modifications are required after intallation, as the installer will create a deamon user *jenkins* and setup up a launch control configuration under `/Libraries/LauchDeamons` that needs to be modified.

1. Move the folder `/Users/Shared/jenkins/Home` to `/Users/jenkins/Home`.
2. Edit the jenkins launch control configuration `/Libraries/LauchDeamons` to match both the user jenkins/staff and it's home directory `/Users/jenkins/Home`.
3. Restart the Mac and verify the Jenkins server to be started under the correct user (jenkins/staff): `ps aux | grep java`

#### Plugin Setup ####

Install the following Jenkins plugins

1. RVM Plugin (configure the projects to use a specific Ruby version and GemSet)
2. iOS Device Connector Plugin (list connected iOS devices and deploy applications)
3. Xcode Plugin (build native iOS apps)
4. Git Plugin (checkup from a git repo)
6. Multijob Plugin (configure aggregating projects) 
5. GreenBalls Plugin (get rid of the blue balls :)
    
#### Jenkins projects ####
