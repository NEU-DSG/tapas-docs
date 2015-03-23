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

##Things that don't seem to stick

The following is a list of things that I have not (yet?) found a way to make "stick" via the "Features". I might make a straight-up module to contain these commands along with what's currently in some of the features, but for now, these updates need to be made manually after the scripts are run.
 * Remove the default content types, "Article" and "Page". We'll probably add something similar at some point, but they will be named in a way that makes sense for the Tapas site.
 * Remove the default user role "administrator" (It is replaced with "site administrator" to distiguish it from Organic Group administrative roles)
 * Institution, Project, Collection, and Record should be set NOT to accept comments, and NOT to show author and date information. I can't seem to save these via the Features interface. (I should be able to do it by manually adding the commands into the exported feature, but I don't want to make manual changes when I might need to export over them again shortly).
 * I don't think that activating blocks to put them in various theme locations is possible via features; this needs to be done manually.

##Test Data

Currently, the best way we have to produce dummy content en masse is the Devel module's Generate Content feature, accessible via Config. Warning: in randomly assigning authors, parent groups, etc, the dummy generation doesn't respect restrictions such as guest-members not being able to create projects, or Record content only being assigned to a Collection item, and not directly to a Project nor an Institution.

At some point, I'd like to create a Drush archive of test content that can be installed by the drupal-testenv.sh script.

