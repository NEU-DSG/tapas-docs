
# Setup checklists for TAPAS server

## Overview

### Componants
* XML database (eXist)
  * http://exist-db.org
* Repository (Fedora)
  * http://fedorarepository.org
* Head to communicate with repo (customized Hydra)
  * Tapas-hydra is built off of Cerebus which is built off of Hydra
  * http://projecthydra.org/
	* https://github.com/NEU-DSG/tapas_rails
* Front end (currently Drupal, but may roll into Hydra)
  * http://www.drupal.org
	* https://github.com/NEU-DSG/tapas-modules
	* https://github.com/NEU-DSG/tapas-themes
	* https://github.com/NEU-DSG/buildtapas



### Prerequirements

* Webserver (we're using Apache)
* JAVA instance (we're using Tomcat)
* MySQL
  * Used by Drupal and ?
* sqllite
  * used by ?
* Ruby on Rails
  * used by Hydra & hydra customizations
	* gems:
* PHP
  * used by Drupal
	* libraries
* node.js
  * used by Rails app to compile assets

### List of installations from VM script
* `java` Java runtime
* `httpd` HTTP demon
* 'lib-magic' is a magic-number recognition library. The build_box.sh script installs:
  * `file-devel` header files and libraries needed to develop programs using 'libmagic'
  * `file-libs` libraries for programs using 'libmagic'
* `sqlite-devel`
* `ghostscript` Postscript and PDF interpreter. Do we use this?
* `ImageMagick` Image conversion
* `redis` http://redis.io from website: "Redis is an open source (BSD licensed), in-memory data structure store, used as database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries. Redis has built-in replication, Lua scripting, LRU eviction, transactions and different levels of on-disk persistence, and provides high availability via Redis Sentinel and automatic partitioning with Redis Cluster." – how are we using this?
* `libreoffice` – on a command-line box? Huh?
* `unzip` – not installed by default?
* `mysql-server`
* `mysql-devel`
* `gcc` I'm SURE this is installed
* `nodejs` used by Rails app

#### Install Phusion passenger
```
chmod o+x /home/vagrant 
bundle exec passenger-install-apache2-module --auto 
sudo cp -f /vagrant/requirements/httpd.conf /etc/httpd/conf/httpd.conf 
echo "127.0.0.1   rails_api.localhost drupal.localhost" | sudo tee -a /etc/hosts
```

### Other Tools

* drush
* Ruby console
* boris
* boris-loader

## Configuring pre-requirements

### Apache configuration

### Tomcat configuration

### PHP configuration & libraries

* `php`
* `mod_php` Apache PHP module
* `php_pdo` PHP Data Objects
* `php-xml` PHP XML
* `php-pecl-memcached` (PECL = PHP Extended Community Library) (memcached = distributed memory object caching system)
* `php-pecl-apc` (PECL = PHP Extended Community Library) (APC = alternative php cache)
* `php-posix` POSIX = portable operating system interface
* `php-gd` GD is a graphics drawing library for PHP
* `php-mbstring` multi-byte character support
* `php-mysql`

```
sudo sed -i "s/max_execution_time = 30/max_execution_time = 120/g" /etc/php.ini
sudo sed -i "s/post_max_size = 8M/post_max_size = 50M/g" /etc/php.ini
sudo sed -i "s/memory_limit = 128M/memory_limit = 400M/g" /etc/php.ini
```

### Ruby on Rails configuration and libraries

### MySQL configuration


## Installing and configuring components

### Installing and configuring eXist

(from the VM script)

```
# the eXist version number
new_exist_vers="2.2"
# the name of the eXist installer file
new_exist_jar="eXist-db-setup-2.2.jar"
# the link to download the installer
new_exist_url="http://sourceforge.net/projects/exist/files/Stable/${new_exist_vers}/${new_exist_jar}"
if [ ! -d "/home/vagrant/.eXist/eXist-${new_exist_vers}" ]; then 
	echo "Installing eXist-DB"
	# Ensure the .eXist directory is present.
	if [ ! -d "/home/vagrant/.eXist" ]; then
		mkdir /home/vagrant/.eXist
	fi
  # Ensure the requirements/local directory is present.
  if [ ! -d "/vagrant/requirements/local" ]; then
    mkdir /vagrant/requirements/local
  fi
  # Download the eXist installer to requirements/local for persistence over box rebuilds.
  if [ -f "/vagrant/requirements/local/${new_exist_jar}" ]; then
    echo "Latest eXist installer already available - skipping download"
  else
    echo "Downloading the latest TAPAS-supported eXist installer"
    wget -nv -P /vagrant/requirements/local $new_exist_url
  fi
	# Install eXist using the auto-install script.
	echo "Installing eXist-${new_exist_vers}"
	java -jar /vagrant/requirements/local/$new_exist_jar /vagrant/requirements/eXist-config/auto-install.xml
	# Create symlink "latest-eXist".
	safeish_symlink "/home/vagrant/.eXist/eXist-${new_exist_vers}" /home/vagrant/latest-eXist
	# Ensure EXIST_HOME and JAVA_HOME environment variables are set.
	if [ -z $JAVA_HOME ]; then
		echo "export JAVA_HOME=/etc/alternatives/jre" >> /home/vagrant/.zprofile
	fi
	if [ -z $EXIST_HOME ]; then
		echo "export EXIST_HOME=/home/vagrant/latest-eXist" >> /home/vagrant/.zprofile
	fi
	source /home/vagrant/.zprofile
	echo "JAVA_HOME is set to: $JAVA_HOME"
	echo "EXIST_HOME is set to: $EXIST_HOME"
	
	sh /vagrant/requirements/eXist-config/run-config.sh
fi
```

### Installing and configuring Fedora repo

* Adding EPEL repository https://fedoraproject.org/wiki/EPEL
  * http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
* Adding REMI repository http://rpms.famillecollet.com/
  * http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
	
Enabling EPEL and REMI repositories

```
sudo rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
rm /home/vagrant/epel-release-6-8.noarch.rpm
rm /home/vagrant/remi-release-6.rpm
sudo sed -i 0,/enabled=0/{s/enabled=0/enabled=1/} /etc/yum.repos.d/remi.repo
```

		REMI Repo

### Installing and configuring the custon Hydra head

Configuring tapas_rails

```
gem install bundler 
bundle install 
rake db:migrate
thor tapas_rails:create_api_user
```

### Installing and configuring drupal site

## Migration & replication notes

## Troubleshooting

* http://rails_api.tapasdev.neu.edu:8080/solr/#/ will show a big red error message if there is a lock file
* http://rails_api.tapasdev.neu.edu:8080/fedora/describe to check if Fedora is running

Services to verify

 * `redis`
 * `mysqld`
 * `existdb`
 * `httpd`
 * `memcached`

### Log Files
* Fedora: and if fedora is not running check the fedora logs at /opt/fedora/server/logs

# Step-by-step (broad outline, needs more detail)

1. Verify OS
1. Verify Apache config
1. Verify MySQL config
1. Verify PHP config
1. Verify Ruby config
1. Install and configure eXist and it's prerequirements
1. Install and configure Fedora and it's prerequirements
1. Install and configure Hydra/tapas_rails
1. Install and configure the Drupal site
1. Data migration





