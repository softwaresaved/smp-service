
# DMPonline deployer's guide - reference information

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 18/03/2014.

---

## Backup and restore databases

To backup a database:

    $ mysqldump -u root -p dmpdev4 > dmpdev4.sql

To restore a database:

    $ mysql -u root -p
    > create database dmpdev4;
    > exit
    $ mysql -u root -p dmpdev4 < dmpdev4.sql

Similarly for dmptest4 and dmptool4.

---

## Create and apply a patch file with local settings

To create:

    $ cp -r DMPonline_v4 local
    $ rm -rf local/git
    $ git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git original
    $ rm -rf original/.git
    $ diff -rupN original/ local/ > local_settings.patch

To apply:

    $ git clone https://github.com/DigitalCurationCentre/DMPonline_v4.git
    $ cd DMPonline_v5.git
    $ patch -p1 < ../local_settings.patch

---

## Run tests

Running the unit (model) and functional (controller) tests for DMPonline allows you check that you have the required dependencies and that DMPonline will be able to interact with your database.

To run the unit and functional tests:

    $ rake db:test:load
    $ rake test:units
    $ rake test:functionals

---

## Configuration and e-mails reference

Configuration settings and how they are used in e-mails.

### Registrations

Configuration files and values:

    config/initializers/devise.rb
       config.mailer_sender = "info@dcc.ac.uk"

    config/application.rb
        config.action_mailer.default_url_options = { :host => 'dmponline.example.com' }

    config/environments/development.rb
        config.action_mailer.default_url_options = { :host => 'localhost:3000' }
        ActionMailer::Base.default :from => 'address@example.com'

Sample e-mail:
    
    From: 	address@example.com
    Reply-To: 	info@dcc.ac.uk
    To:         fredbloggs@gmail.com
    Subject: 	Confirm your DMPonline account

    <p>Welcome to DMPonline, fredbloggs@gmail.com!</p>
    <p>Thank you for registering at <a href="http://localhost:3000/">DMPonline</a>. Please confirm your email address:</p>
    <p><a href="http://localhost:3000/users/confirmation?confirmation_token=hYCpqbMu5hi9FbmR6YJe">Click here to confirm your account</a> (or copy http://localhost:3000/users/confirmation?confirmation_token=hYCpqbMu5hi9FbmR6YJe into your browser).</p>

### Passwords

Configuration files and values:

    config/initializers/devise.rb
       config.mailer_sender = "info@dcc.ac.uk"

    config/application.rb
        config.action_mailer.default_url_options = { :host => 'dmponline.example.com' }

    config/environments/development.rb
        config.action_mailer.default_url_options = { :host => 'localhost:3000' }
        ActionMailer::Base.default :from => 'address@example.com'

Sample e-mail:
    
    From: 	address@example.com
    Reply-To: 	info@dcc.ac.uk
    To:         fredbloggs@gmail.com
    Subject: Reset password instructions

    <p>Hello fredbloggs@gmail.com!</p>
    <p>Someone has requested a link to change your <a href="http://localhost:3000/">DMPonline</a> password. You can do this through the link below.</p>
    <p><a href="http://localhost:3000/users/password/edit?reset_password_token=DxzhpiTKoSvkpvtXJY3z">Change my password</a></p>
    <p>If you didn't request this, please ignore this email.</p>
    <p>Your password won't change until you access the link above and create a new one.</p>

### Permission changes

Configuration files and values:

    app/mailers/user_mailer.rb
        default from: 'info@dcc.ac.uk'

    config/application.rb
        config.action_mailer.default_url_options = { :host => 'dmponline.example.com' }

    config/environments/development.rb
        config.action_mailer.default_url_options = { :host => 'localhost:3000' }

Sample e-mail:

    From: info@dcc.ac.uk
    To:         fredbloggs@gmail.com
    Subject: You have been given access to a Data Management Plan

    <p>Hello Fred Bloggs</p>
    <p>You have been given read-only access to the DMP "<a href="http://localhost:3000/projects/my-plan-dcc-template">My plan (DCC Template)</a>".</p>

### Error reports

Configuration files and values:

    config/environments/development.rb
       :email_prefix => "[DMPonline4 ERROR] ",
       :sender_address => %{"No-reply" <noreply@dcc.ac.uk>},
       :exception_recipients => %w{dmponline@dcc.ac.uk}

Sample e-mail:

    From: No-reply <noreply@software.ac.uk>
    To: dmponline@dcc.ac.uk
    Subject: [DMPonline4 ERROR] ...

    ...

### Contact Us form

Configuration files and values:

    config/initializers/contact_us.rb
        config.mailer_to = "dmponline@dcc.ac.uk"

Sample e-mail:

    From: fredbloggs@gmail.com
    Reply-To: fredbloggs@gmail.com
    To: dmponline@dcc.ac.uk

    ...
