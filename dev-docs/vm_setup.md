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
  "So what you want do is delete everything in the /var/www/html directory ​*without*​ deleting the directory itself or the buildtapas.sh script. Then you want to rerun the script with exactly the same parameters as are passed in by the provisioning script"
    
4. make sure you have the most recent build of the exist-app
  ```
    TODO
  ```


5. make sure apache http is running (while sshed into vm)
  ```
    sudo service httpd status
  ```
  (to reboot, use 
    ```
      sudo service httpd restart
    ```
  )
  
6. make sure exist is running, go to http://localhost:8848/exist

7. make sure solr is running, go to http://localhost:8986/solr

8. make sure rails is running, go to http://rails_api.localhost:8080/

9. make sure resque is running
  (while ssh'ed into vm, leave this up in a terminal tab/window)
  ```
    cd ~/tapas_rails
    QUEUE=* rake environment resque:work
  ```
  go to http://rails_api.localhost:8080/resque/overview and you should see 1 worker
  

  
  
