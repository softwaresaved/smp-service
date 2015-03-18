# DMPonline deployer's guide - Apache deployment

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 18/03/2014.

## Introduction

How to deploy [DMPonline](https://github.com/DigitalCurationCentre/DMPonline_v4) under Apache web server. This guide assumes you have read the [DMPonline deployer's guide](./DMPonlineDeployersGuide.md).

Ruby on Rails [deploying](http://rubyonrails.org/deploy/) recommend [Phusion Passenger](https://www.phusionpassenger.com/), also known as mod_rails.

In what follows, [RVM](https://rvm.io/), the Ruby version manager, was used to manage Ruby versions. 

We assume this is located in /home/user/.rvm/. If you are not using RVM then change file paths to point to your version of Ruby, the directory where your Ruby gems are installed etc.

We assume your host name is host.dept.place.ac.uk - replace this with your actual host name.

---

## Install Phusion Passenger

[Installing or upgrading on Red Hat, Fedora, CentOS or ScientificLinux](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#_installing_or_upgrading_on_red_hat_fedora_centos_or_scientificlinux) warns that "The RPMs are currently unmaintained .... For more recent versions of Phusion Passenger, you are suggested to install from gem or tarball instead." so the [Generic installation, upgrade and downgrade method: via RubyGems](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#rubygems_generic_install) will be used.

Install latest stable gem:

    $ gem install passenger
    Fetching: passenger-5.0.1.gem (100%)
    Building native extensions.  This could take a while...
    Successfully installed passenger-5.0.1
    Parsing documentation for passenger-5.0.1
    Installing ri documentation for passenger-5.0.1
    1 gem installed

Run Passenger installer. Note that the user guide comments that the "'installer' doesn't actually install anything. It checks whether all required dependencies are installed, invokes the compiler, and tells you how to modify the Apache configuration file. It doesn't copy any files to outside the Phusion Passenger source directory."

    $ passenger-install-apache2-module

Select Ruby when requested, using the cursor keys.

If you get a warning like:

    Warning: some directories may be inaccessible by the web server!

    The web server typically runs under a separate user account for security
    reasons. That user must be able to access the Phusion Passenger files.
    However, it appears that some directories have too strict permissions. This
    may prevent the web server user from accessing Phusion Passenger files.

    sudo chmod o+x "/home/user"

then fix permissions. For example:

    $ chmod go+rx /home/user/

---

## Update Apache configuration to load Passenger

Edit /etc/httpd/conf/httpd.conf. Add:

    LoadModule passenger_module /home/user/.rvm/gems/ruby-2.0.0-p247/gems/passenger-5.0.1/buildout/apache2/mod_passenger.so
    <IfModule mod_passenger.c>
      PassengerRoot /home/user/.rvm/gems/ruby-2.0.0-p247/gems/passenger-5.0.1
      PassengerDefaultRuby /home/user/.rvm/gems/ruby-2.0.0-p247/wrappers/ruby
    </IfModule>

If using another version of Ruby (e.g. 2.0.0-p643), or there is a more up-to-date version of Passenger then update the version numbers in the paths as required.

Restart Apache:

    $ /etc/init.d/httpd restart

Check Passenger is running:

    $ passenger-memory-stats

This should show version, date, Apache process and Passenger process information.

See Passenger status:

    $ rvmsudo passenger-status

Note down the process ID (PID).

Find out under what user Passenger is running:

    $ ps -o pid,user,comm -p 8686

### Troubleshooting - `Cannot stat ... Permission denied`

If the Apache logs show a message like:

    $ cat /etc/httpd/logs/error.log
    [ 2015-03-05 09:39:11.9734 2960/7f4db825c7e0
    agents/LoggingAgent/Main.cpp:447 ]: ERROR: Cannot stat
    '/home/user/.rvm/gems/ruby-2.0.0-p247/gems/passenger-5.0.1':
    Permission denied (errno=13) 
    in 'void initializeUnprivilegedWorkingObjects()' (Main.cpp:270)
    in 'int runLoggingAgent()' (Main.cpp:434)

then Apache cannot access Ruby and/or its gems. 

Fix permissions on the directory:

    $ chmod go+rx /home/user/

Restart Apache:

    $ /etc/init.d/httpd restart

---

## Update Apache configuration to expose DMPonline

Edit /etc/httpd/conf/httpd.conf. Add:
    
    RailsEnv development
    DocumentRoot /home/user/DMPonline_v4/public
    <Directory /home/user/DMPonline_v4/public>
      # This relaxes Apache security settings.
      AllowOverride all
      # MultiViews must be turned off.
      Options -MultiViews
      # Uncomment this if you're on Apache >= 2.4:
      #Require all granted
    </Directory>

Remember to replace host.dept.place.ac.uk with your host name.

Restart Apache:

    $ /etc/init.d/httpd restart

Visit http://host.dept.place.ac.uk and you should see DMPonline.

---

## Configure for HTTPS access only

Edit /etc/httpd/conf/httpd.conf. Add:

    # Rewrite everything to use https.
    RewriteEngine on
    RewriteCond %{SERVER_PORT} =80
    RewriteRule ^(.*) https://%{SERVER_NAME}%{REQUEST_URI}

Restart Apache:

    $ /etc/init.d/httpd restart

Visit http://host.dept.place.ac.uk and you should be redirected to https and then you should see DMPonline.

---

## Switch to DMPonline production version

Edit /etc/httpd/conf/httpd.conf. Comment out the line: 

    RailsEnv development

to give:

    # RailsEnv development

Restart Apache:

    $ /etc/init.d/httpd restart

---
