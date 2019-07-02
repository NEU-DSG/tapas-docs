
# Setup checklists for TAPAS server

## Overview of the main components

### Ruby on Rails + Hydra/Samvera

Hydra (now “Samvera”) is a Ruby on Rails gem which provides components and infrastructure for running a digital repository. The [tapas_rails application](https://github.com/NEU-DSG/tapas_rails) stores, indexes, and serves out TEI files and associated images. In the future, the Rails app will also manage users and the web interface.

Parts and dependencies:

* git;
* Redis;
* an implementation of MySQL server and the dev package;
* Fedora at version 3.6.1 and Solr at version 4.0.0 (see section below);
* Ruby at version 2.0.0;
* tapas_rails, including notable gems:
	* passenger at version 5.0.15,
	* cerberus_core at version 0.0.1,
		* curb
			* ([requires libcurl packages](https://github.com/taf2/curb#installation)),
		* logger at version 1.2.8 (not available anymore; run `bundle update logger --patch` to use version 1.2.8.1), and
	* hydra-head at version 7.2.0.

To obtain and use Ruby at a specific version, install the Ruby Version Manager (RVM) then run:

		rvm install 2.0.0
		rvm use 2.0.0

On a fresh copy of tapas_rails, with Ruby, Redis, and MySQL installed:

		gem install bundler
		bundle update logger --patch
		./REDIS_HOME/src/redis-server
		passenger start
		QUEUE=* rake environment resque:work 

The process for starting Fedora and Solr is described in the next section.

Useful links:

* The Samvera home page: <https://samvera.org/>
* Downloads for Redis: <https://redis.io/download>
* Installation instructions for RVM: <https://rvm.io/rvm/install>
* The (very, very old) cerberus_core gem repository: <https://github.com/NEU-Libraries/cerberus_core>
* “What happened to [Logger] v1.2.8?”: <https://github.com/nahi/logger/issues/3#issuecomment-455776902>
* Installation instructions for the curb gem: <https://github.com/taf2/curb#installation>
* hydra-head gem, v7.2.0: <https://github.com/samvera/hydra-head/tree/v7.2.0>


#### Fedora + Solr + Jetty

The Hydra stack is founded on the Fedora repository, with Solr (and [Blacklight](http://projectblacklight.org/)) for indexing and discovery. Jetty is used to serve them out.

TAPAS is version-locked to Fedora version 3.6.1 and Solr 4.0.0. Because the hydra-head’s `hydra:jetty` generator [won’t be able to find these on GitHub](https://github.com/samvera-deprecated/jettywrapper/blob/master/lib/jettywrapper.rb#L60), an alternate path for `ZIP_URL` has been set. An archive containing Solr and Fedora should be placed at `tapas_rails/tmp/new-solr-schema.zip`.

Once the archive is in place, you can initialize Jetty:

		rails g hydra:jetty
		rake jetty:config

Start Jetty with `rake jetty:start`, and stop it with `rake jetty:stop`.

With Jetty running, Solr should be available at <http://localhost:8983/solr/>. Fedora should be available at <http://localhost:8983/fedora/>.

Useful links:

* Repository for the jettywrapper gem (deprecated): <https://github.com/samvera-deprecated/jettywrapper>
* Code for setting up Hydra-Jetty in the “plattr” virtual environment: <https://github.com/NEU-DSG/plattr/blob/123baabda636fe936610e04552084cbe8fdb1be3/scripts/plattr_provisioning.sh#L43-L60>
* Samvera’s instructions on setting up hydra-jetty: <https://github.com/samvera/hydra-works/wiki/Lesson:-install-hydra-jetty>


### eXist-DB

eXist is a Java-based XML database, used to derive metadata and XHTML from TEI files. It also stores and indexes TEI documents. TAPAS-specific code is found in the [tapas-xq repository](https://github.com/NEU-DSG/tapas-xq).

Parts and dependencies:

* Java at version 8+;
* eXist-DB at a version between 2.2 and 3.6.1 (version 2.2 can't be run with Java 9+); and
* the TAPAS-xq app.

Useful links:

* Downloads for eXist JAR files: <https://bintray.com/existdb/releases/exist>
* On installing eXist: <http://exist-db.org/exist/apps/doc/basic-installation> and <http://exist-db.org/exist/apps/doc/advanced-installation.xml>
* On setting up eXist to start with the server: <http://exist-db.org/exist/apps/doc/advanced-installation.xml#service>
* Downloads for the TAPAS-xq application: <https://github.com/NEU-DSG/tapas-xq/releases>
* On deploying TAPAS-xq: <https://github.com/NEU-DSG/tapas-xq#installation>


### Drupal


* **eXist-DB:** XML database (eXist)
  * http://exist-db.org
* Repository (Fedora)
  * http://fedorarepository.org
* Head to communicate with repo (customized Samvera)
  * Tapas_rails is built off of Cerebus which is built off of Hydra
  * http://projecthydra.org/
	* https://github.com/NEU-DSG/tapas_rails
* Front end (currently Drupal, but may roll into Samvera)
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





