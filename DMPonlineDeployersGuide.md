
# DMPonline deployer's guide

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 13/02/2014.

## Introduction

[DMPonline](https://github.com/DigitalCurationCentre/DMPonline_v4) is a Ruby on Rails application that uses Ruby and MySQL Server. This page summarises how to deploy DMPonline and these and other dependencies.

---

## Dependencies - Scientific Linux 6

    $ cat /etc/redhat-release 
    Scientific Linux release 6.5 (Carbon)

Install dependencies for Rails:

    $ sudo yum install nodejs

Install dependencies for DMPonline:

    $ sudo yum install wkhtmltopdf
    $ wkhtmltopdf -V
    Name:
      wkhtmltopdf 0.10.0 rc2
    $ sudo yum install libcurl-devel

---

## Dependencies - Ubuntu 14.04.1 LTS

Install general dependencies:

    $ sudo apt-get install git
    $ sudo apt-get install curl

Install dependencies for Rails:

    $ sudo apt-get install nodejs

Install dependencies for DMPonline:
<pre>
    $ sudo apt-get install wkhtmltopdf
    $ wkhtmltopdf -V
    Name:
      wkhtmltopdf 0.10.0 rc2
    $ sudo apt-get install libcurl4-openssl-dev
</pre>

---

## RVM and Ruby 2.0.0-p247

* Ruby Version Manager
* https://rvm.io
* https://rvm.io/rvm/basics

Install RVM:

    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    $ \curl -sSL https://get.rvm.io | bash -s stable --ruby

Dependencies for RVM are installed by RVM itself:

    Installing required packages: gawk, g++, libreadline6-dev, zlib1g-dev, libssl-dev, libyaml-dev, libsqlite3-dev, sqlite3, autoconf, libgdbm-dev, libncurses5-dev, automake, libtool, bison, libffi-dev

Install Ruby 2.0.0-p247:

    $ source ~/.rvm/scripts/rvm
    $ rvm list known
    $ rvm install 2.0.0-p247
    $ rvm use 2.0.0-p247

Set Ruby 2.0.0-p247 as default:

    $ rvm --default use 2.0.0-p247
    $ ruby -v
    ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-linux]

---

## Rails 3.2.13

* Web application development framework written in Ruby.
* http://rubyonrails.org/

Install:

    $ gem install rails
    $ rails -v
    Rails 3.2.13

Create sample project:

    $ rails new myapp
    $ cd myapp
    $ rails server

Browse to http://localhost:3000/ and you should see: Welcome aboard: You're riding Ruby on Rails!"

### Troubleshooting - `Could not find a JavaScript runtime`

If you get the following:

    $ rails new myapp
    $ cd myapp
    $ rails server
    /disk/ssi-dev0/home/mjj/lib/ruby/gems/2.1.0/gems/execjs-2.3.0/lib/execjs/runtimes.rb:45:in `autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)

Then you need to yum or apt-get install nodejs.

---

## MySQL server 5.0+

Install - Scientific Linux 6:

    $ sudo yum install mysql-server
    $ sudo yum install mysql-devel

Install - Ubuntu 14.04.1 LTS:

    $ sudo apt-get install mysql-server
    $ sudo apt-get install libmysqlclient-dev

Configure:

    $ mysql --version
    mysql  Ver 14.14 Distrib 5.1.73, for redhat-linux-gnu (x86_64) using readline 5.1
    $ sudo su -
    $ service mysqld start
    $ mysql_secure_installation
    Enter current password for root (enter for none): 
    Change the root password? [Y/n] Y
    Remove anonymous users? [Y/n] Y
    Disallow root login remotely? [Y/n] Y
    Remove test database and access to it? [Y/n]  Y
    Reload privilege tables now? [Y/n] Y

---

## DMPonline

Get DMPonline:

    $ git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git
    $ cd DMPonline_v4

Copy database configuration:

    $ cp config/database_example.yml config/database.yml

Edit config/database.yml and update:

* database
* username
* password

Edit the following lines in config/environments/development.rb. Provide your own SMTP server URL and port, e-mail prefix, and e-mail addresses:

    config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
    ActionMailer::Base.default :from => 'address@example.com'
    ActionMailer::Base.smtp_settings = { :address => "localhost", :port => 1025 }

          :email_prefix => "[DMPonline4 ERROR] ",
          :sender_address => %{"No-reply" <noreply@dcc.ac.uk>},
          :exception_recipients => %w{dmponline@dcc.ac.uk}

Create a security token:

    $ irb
    > require 'securerandom'
    > SecureRandom.hex(64)

Or:

    $ rake secret

Edit config/initializers/devise.rb. Provide your own e-mail address and copy the security token into the pepper:

    config.mailer_sender = "info@dcc.ac.uk"
      config.pepper = "de451fa8d44af2c286d922f753d1b10fd23b99c10747143d9ba118988b9fa9601fea66bfe31266ffc6a331dc7331c71ebe845af8abcdb84c24b42b8063386530"

Create another security token, as above.

Edit config/initializers/secret_token.rb. Copy in the security token:

    DMPonline4::Application.config.secret_token = '4eca200ee84605da3c8b315a127247d1bed3af09740090e559e4df35821fbc013724fbfc61575d612564f8e9c5dbb4b83d02469bfdeb39489151e4f9918598b2'

Find the path to wkhtmltopdf:

    $ which wkhtmltopdf
    /usr/local/bin/wkhtmltopdf

Edit config/application.rb. Update the mailer URL and, if necessary, path to wkhtmltopdf:

    config.action_mailer.default_url_options = { :host => 'dmponline.example.com' }

    WickedPdf.config = {
        :exe_path => '/usr/local/bin/wkhtmltopdf'
    }

Update db/seeds.rb (as recommented on the DMPonline [wiki](https://github.com/DigitalCurationCentre/DMPonline_v4/wiki/1.-Local-Installation):

    $ wget https://raw.githubusercontent.com/DigitalCurationCentre/DMPonline_v4/6791c19e751560ac9a18d3bb80f8ff21bc31ff39/db/seeds.rb
    $ mv seeds.rb db/seeds.rb

Install Ruby gems:

    $ bundle update

Create the database:

    $ rake db:setup

Start the server:

    $ rails server

Browse to http://localhost:3000/ and you should see DMPonline.

### Troubleshooting - `bundle update` fails

If you forget to yum or apt-get install a dependency, then `bundle update` or `gem install` operations needing these dependencies will fail e.g.

    $ gem install sqlite3 -v '1.3.10'
    sqlite3.h is missing. Try 'port install sqlite3 +universal',
    'yum install sqlite-devel' or 'apt-get install libsqlite3-dev'

    $ gem install curb -v '0.8.6'
    An error occurred while installing curb (0.8.6), and Bundler cannot continue.
    Make sure that `gem install curb -v '0.8.6'` succeeds before bundling.

    $ gem install mysql2 -v '0.3.17'
    mysql.h is missing.  please check your installation of mysql and try again.

After doing the yum or apt-get install, reinstall the gem then rerun `bundle update`.

### Troubleshooting - `rake db:setup` fails

If you get the following:

    $ rake db:setup
    /disk/ssi-dev0/home/mjj/.rvm/gems/ruby-2.2.0/gems/activesupport-3.2.13/lib/active_support/values/time_zone.rb:270: warning: circular argument reference - now
    dmpdev4 already exists
    Access denied for user 'mysql'@'localhost' (using password: YES). 
    Please provide the root password for your mysql installation
    > 
    rake aborted!
    NoMethodError: undefined method `settings' for nil:NilClass
    /disk/ssi-dev0/home/mjj/DMPonline_v4/db/seeds.rb:765:in `block in <top (required)>'
    (See full trace by running task with --trace)

Then you need to update db/seeds.rb as suggested on the wiki.

### Troubleshooting - `Connection refused - connect(2) for "localhost" port 1025`

If you see this message in the logs then you need to set your SMTP hostname and port number to conform to your local setup.

### Troubleshooting - View Plans fails

If you click View Plans and see:

    app/controllers/projects_controller.rb
    ...
    A NoMethodError occurred in projects#index:
    
      undefined method `name' for nil:NilClass
      activerecord (3.2.13) lib/active_record/associations/has_many_association.rb:57:in `cached_counter_attribute_name'
    ...                        
    if (current_user.shibboleth_id.nil? || current_user.shibboleth_id.length == 0) && !cookies[:show_shib_link].nil? && cookies[:show_shib_link] == "show_shib_link" then
            flash.notice = "Would you like to #{view_context.link_to 'link your DMPonline account to your institutional credentials?', user_omniauth_shibboleth_path}".html_safe
    end
    @projects = current_user.projects.filter(params[:filter])
    @has_projects = current_user.projects.any? # unfiltered count
    respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @projects }
    end

then check your Ruby version. This problem can arise if you are using Ruby 2.0.0 and not 2.0.0-p247, for example.

---

## Create a DMPonline super-admin

To create a super-admin:

    $ mysql -u root -p
    > insert into roles (id,name) values (1,'admin');
    > insert into users_roles (user_id,role_id) value (1,1);

where user_id (1 in this example) is the id of the user you want to make a super-admin.

Alternatively:

    $ rails console
    > user = User.find_by_email('user@someplace.org')
    > user.roles.create name: 'admin'

See:

* https://github.com/DigitalCurationCentre/DMPonline_v4/issues/141
* https://github.com/DigitalCurationCentre/DMPonline_v4/issues/143

---

## Create a DMPonline organisation admin

To create an organisation admin:

    $ mysql -u root -p
    > insert into roles (id,name) values (2,'org_admin');
    > insert into users_roles (user_id,role_id) value (1,2);

where user_id (1 in this example) is the id of the user you want to make a super-admin.

Alternatively:

    $ rails console
    > user = User.find_by_email('user@someplace.org')
    > user.roles.create name: 'org_admin'

See:

* https://github.com/DigitalCurationCentre/DMPonline_v4/issues/141
* https://github.com/DigitalCurationCentre/DMPonline_v4/issues/143
* [Using the DMPonline admin interface: a guide to customising the tool
](http://www.dcc.ac.uk/sites/default/files/documents/tools/dmpOnline/DMPonline-admin-interface-guide.pdf) 1.0, 20/06/14.

---

## Backup and restore databases

To backup a database:

    $ mysqldump -u root -p dmpdev4 > dmpdev4.sql

To restore a database:

    $ mysql -u root -p
    > create table dmpdev4;
    > exit
    $ mysql -u root -p dmpdev4 < dmpdev4.sql

Similarly for dmptest4 and dmptool4.

---

## Create and apply a patch file with local settings

To create:

    $ cp -r DMPonline_v4 custom
    $ git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git original
    $ rm -rf original/.git
    $ diff -rupN original/ new/ > local_settings.patch

To apply:

    $ git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git
    $ cd DMPonline_v5.git
    $ patch -p1 < ../local_settings.patch