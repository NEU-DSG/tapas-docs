##Setting up the TAPAS Drupal development and testing environment:

  * Ensure you have up-to-date versions of VirtualBox and Vagrant installed
  * Download the "Vagrant for Drupal Development" (vdd) base box from drupal.org into its own folder
  * Run `vagrant up` to initialize the box
  * Copy the scripts from http://github.com/NEU-DSG/tapas-docs/dev-docs/scripts into the "data" directory that "vagrant up" created.
  * You might need to make these executable again (`chmod 755 *.sh`)
  * Run `vagrant ssh` to log into the virtual box
  * Run the deployment script -- this will:
     - download and install the latest reccomended version of Drupal
	  - download and install contributed modules
	  - clone the http://github.com/NEU-DSG/tapas-modules repo into /sites/all/modules
	  - clone the http://github.com/NEU-DSG/tapas-themes repo into /sites/all/themes
	  - enable features and modules.
  * Run the testenv script. this will:
     - Create a /sites/all/modules/development directory
	  - Download and enable modules used for development and testing that aren't needed (or wanted) in the production build.
  * On your host machine, go to `drupal7.dev` in your browser of choice.


## UPDATE

There are enough things that can't be set using Features alone that I'm looking into other options, to avoid too heavy of a manual component in setting up development or production environments.

Currently, I'm looking into using `drush make` to create our own distribution profile. 

