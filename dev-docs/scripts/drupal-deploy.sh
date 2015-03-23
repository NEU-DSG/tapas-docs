#!/bin/sh

cd /var/www/drupal7
echo "---------------------------------------------------------"
echo "downloading Drupal..."
drush dl
sleep 5
echo "---------------------------------------------------------"
echo "moving Drupal files..."
mv drupal-*/* .
mv drupal-*/.htaccess .
mv drupal-*/.gitignore .
echo "---------------------------------------------------------"
echo "installing Drupal..."
drush @drupal7 si standard -y
echo "---------------------------------------------------------"
echo "downloading contributed modules..."
mkdir contrib
drush -y dl views entity ctools og features entityreference views_bulk_operations addressfield context biblio date rules link entityreference_prepopulate name --destination=contrib
sleep 5
echo "---------------------------------------------------------"
echo "moving moving modules to the modules folder..."
mv contrib sites/all/modules
echo "---------------------------------------------------------"
echo "removing example-features that conflict with tapas features..."
rm -rf sites/all/modules/contrib/og/og_example
rm -rf sites/all/modules/contrib/date/date_migrate/date_migrate_example
echo "---------------------------------------------------------"
echo "enabling modules..."
drush -y en ctools features views entity addressfield checklistapi contact 
drush -y en entityreference views_bulk_operations date entity_token admin_menu name 
drush -y en og views_ui entityreference_prepopulate
drush -y en og_access og_context og_register
drush -y en og_ui admin_menu date link
echo "---------------------------------------------------------"
echo "disabling admin overlay effect..."
drush -y dis overlay
echo "---------------------------------------------------------"
echo "cloning tapas-modules repo..."
cd sites/all/modules
git clone https://github.com/NEU-DSG/tapas-modules
sleep 5
echo "---------------------------------------------------------"
echo "cloning tapas-themes repo..."
cd ../themes
git clone https://github.com/NEU-DSG/tapas-themes
sleep 5
cd ../../..
echo "---------------------------------------------------------"
echo "Rebuilding accesss permissions..."
drush php-eval 'node_access_rebuild();'