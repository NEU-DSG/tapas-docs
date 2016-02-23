How to know if you have everything up and running locally in your VM
1. make sure you have the most recent code
  ``` 
    cd ~/plattr 
    git pull
    cd ~/tapas_rails
    git pull
  ```
2. make sure your vm is built
  ```
    cd ~/plattr
    vagrant up
  ```
3. make sure you have the most recent build of the tapas-drupal app
  delete everything in the /var/www/html directory *without* deleting the directory itself or the buildtapas.sh script. rerun the script with exactly the same parameters as are passed in by the provisioning script (```/bin/bash --login /var/www/html/buildtapas.sh "root" "" "tapas_drupal" "drupaldb" "drupaldb"```)
    
4. make sure you have the most recent build of the exist-app. go to [http://localhost:8848/exist](http://localhost:8848/exist) and click package manager then find tapas-xq and make the version number matches the most recent version on [https://github.com/NEU-DSG/tapas-xq](https://github.com/NEU-DSG/tapas-xq). if it does not, follow the instructions here: [https://github.com/NEU-DSG/tapas-xq](https://github.com/NEU-DSG/tapas-xq) to install and deploy


5. make sure apache http is running (while sshed into vm)
  ```
    sudo service httpd status
  ```
  (to reboot, use 
    ```
      sudo service httpd restart
    ```
  )
  
6. make sure exist is running, go to [http://localhost:8848/exist](http://localhost:8848/exist)

7. make sure solr is running, go to [http://localhost:8986/solr](http://localhost:8986/solr) (If solr is down locally try stopping and starting jetty with rake jetty:stop and rake jetty:start. If solr is down on prod, it has to be restarted by restarting tomcat with /sbin/service tomcat restart.)

8. make sure rails is running, go to [http://rails_api.localhost:8080/](http://rails_api.localhost:8080/)

9. make sure resque is running
  (while ssh'ed into vm, leave this up in a terminal tab/window)
  ```
    cd ~/tapas_rails
    QUEUE=* rake environment resque:work
  ```
  go to [http://rails_api.localhost:8080/resque/overview](http://rails_api.localhost:8080/resque/overview) and you should see 1 worker
  

  
  
To rebuild the reading interfaces run 
  ```
    RAILS_ENV=production bundle exec thor tapas_rails:rebuild_reading_interfaces
  ```
when you are ssh'ed in as tapas_rails user, locally it would just be 
  ```
    bundle exec thor tapas_rails:rebuild_reading_interfaces
  ```
