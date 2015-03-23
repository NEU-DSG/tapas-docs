#!/bin/sh

cd /var/www/drupal7
echo "---------------------------------------------------------"
echo "downloading development related modules contributed modules..."
mkdir develop
drush -y dl devel examples advanced_help checklistapi qa_checklist --destination=develop
sleep 5
echo "---------------------------------------------------------"
echo "moving moving modules to the modules folder..."
mv develop sites/all/modules
echo "---------------------------------------------------------"
echo "enabling modules..."
drush -y en devel advanced_help checklistapi 
drush -y en devel_generate qa_checklist
echo "---------------------------------------------------------"
echo "creating sample users...."
drush -y ucrt PennyPaidmember --mail="penny@example.com" --password="penny"
drush -y ucrt PeterPaidmember --mail="peter@example.com" --password="peter"
drush -y ucrt GertieGuest --mail="gertie@example.com" --password="gertie"
drush -y ucrt GlenGuest --mail="glen@example.com" --password="glen"
