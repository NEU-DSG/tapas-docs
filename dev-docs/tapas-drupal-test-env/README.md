Instructions for setting up the TAPAS Drupal test environemtn

1. Ensure that you have VirtualBox and Vagrant installed.
2. Get the Vagrant for Drupal Development base-box at https://www.drupal.org/project/vdd
3. From inside the vdd folder, type the command: vagrant up
4. Then wait. The initial set up can take quite a while, and might sometimes look like it's hung.
5. Ensure you are connected to the internet.
6. Copy the following two scripts from Github into vdd/data:
   -- github.com/NEU-DSG/tapas-docs/dev-docs/tapas_drupal_depolyment/tapas_drupal_deployment.sh
	-- github.com/NEU-DSG/tapas-docs/dev-docs/dapas_drupal_testenv/tapas_drupal_testenv.sh
7. Go to vdd/
8. Type: vagrant ssh
9. This will send you into a shell running on the virual machine. Type the following commands:
    cd sites/data/drupal7
	 ../tapas_drupal_deployment.sh
	 ../tapas_drupal_testenv.sh
10. The deployment script will take a while, since it's downloading and installing Drupal and the relevant modules, as well as enabling them. The testenv script does the same with modules that we only want in the test environment, not live.
11. Point your browser to: drupal7.dev
12. Username: root  Password: root
13. Have Fun!
