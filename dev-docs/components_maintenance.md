# Managing the site

## Logging in

Use `dzdo` for sudo privileges.

To log in as the "tapas_rails" user:

    dzdo su - root
    su - tapas_rails
    cd tapas_rails/current

## Deploying Rails

Capistrano runs deployment and keeps the last five deploys. If a deploy doesn't work, you can go back to a previous iteration.

When tapas_rails code changes, re-deploy.

  - To staging: `bundle exec cap staging deploy`
  - To production: `bundle exec cap production deploy`

This can also be done from within tapas_rails directory of your local Vagrant environment.


## Tomcat

Apache Tomcat runs both Fedora and Solr.

Tomcat is a service on both production (as "tomcat7") and staging (as "tomcat").

To check Tomcat's status: `sudo service SERVICENAME status`

To restart: `sudo service SERVICENAME restart` (or "start" or "stop")

There are custom scripts which start Tomcat as the tapas_rails user. <!-- Not sure what this is about. ~Ashley -->


### Fedora

If Fedora is running, you should see description of the Fedora install at http://railsapi.tapas.neu.edu:8080/fedora .

To restart Fedora, restart Tomcat.


### Solr

If Solr is running, you should see a management interface at http://railsapi.tapas.neu.edu:8080/solr . If there's anything wrong, a big red or yellow error message will appear on the main page.

#### Querying

The web interface above can be useful for querying and debugging. To query, select a core from the Core Selector dropdown. TAPAS uses two cores right now: "development" (for Rails) and "drupal" (for Drupal). With a core selected, you can see an expanded menu, including the "Query" option.

##### Useful queries

The below code snippets are formatted like HTTP parameters, because queries can also be executed RESTfully. For example: <railsapi.tapas.neu.edu:8080/solr/development/select?q=*%3A*&amp;wt=xml&indent=true>

Everything after equals sign can instead be entered into the correct field in the Query form.

**Get information on an identifier**

    q=id:changeme:120
    fl=id,active_fedora_model_ssi,project_pid_ssi,drupal_access_ssim,title_info_title_ssi,display_authors_ssim,upload_status_ssi,upload_status_time_dtsi,did_ssim

**Find the most recently completed**

    q=upload_status_ssi:COMPLETE
    sort=upload_status_time_dtsi desc

**Find the number of CoreFiles**

    q=active_fedora_model_ssi:CoreFile


## Apache

Apache runs Phusion Passenger.

To check Apache's status, go to any known url to see if there is a connection.

Apache's service name is "httpd", and it can be restarted with `sudo service httpd restart`.

### Phusion Passenger

Passenger runs the Rails server. To restart Rails, restart Passenger. To restart Passenger, restart Apache.

If Passenger and Rails are up, <http://railsapi.tapas.neu.edu> will have data on view packages (HTML on the staging server).

### Ruby on Rails

*TO DO*

### Resque

Resque controls the queueing of jobs, assigning them to workers. To check the queues, go to <http://railsapi.tapas.neu.edu/resque>. If jobs are processing, you'll see them in the bottom part of the page. If jobs are queued, you'll see them in the jobs column in the upper left. The last row of the queues table shows any failed jobs.

The "resque" service can be checked and restarted from the command line (see Tomcat).

#### Stalled queues

If Resque stalls, there will be incomplete jobs listed, but zero workers working.

  1. Note the number of incomplete jobs.
  2. Log in to the server.
  3. Log in as "tapas_rails" and change directories to the current deploy.
  4. Restart Resque
    1. On production: `bundle exec cap production resque:restart`
    2. On staging: `bundle exec cap staging resque:restart`
  5. On production, log into TAPAS as an administrator and re-save the most recent TEI documents, projects, and collections.


## eXist-DB

eXist runs on its own Jetty server. On production it is available at <http://tapas.neu.edu:8868/exist/apps/dashboard/index.html>. On staging it is available via proxy server: <http://p8868-tapasdev.neu.edu.ezproxy.neu.edu/exist/>.

The "existdb" service can be checked and restarted from the command line (see Tomcat).

