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
drush -y en devel examples advanced_help checklistapi qa_checklist
