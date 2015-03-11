
# Customing DMPonline into a prototype SMP service

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 11/03/2014.

## Introduction

This document notes the main changes that need to be made, and have been made, to [DMPonline](https://github.com/DigitalCurationCentre/DMPonline_v4) to use it as a prototype service for software management plans.

The version of DMPonline used was the latest at the time of writing, master branch, commit [6236385f55189be55f2b470b5ee3563615d964c1](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/6236385f55189be55f2b470b5ee3563615d964c1) 24 Nov 2014.

DMPonline was forked into an [smp-service](https://github.com/softwaresaved/smp-service) repository and development then done within an [smp-prototype](https://github.com/softwaresaved/smp-service/tree/smp-prototype) branch of the [smp-service](https://github.com/softwaresaved/smp-service) repository.

Where possible changes have been made that minimize the divergence from the DMPonline code and could also be ingested back into DMPonline.

---

## Mapping DMPonline concepts and data model to software management plans

DMPonline's concepts are as follows:

* Theme:
  - A type of information e.g. Data Description, Data Type, Storage and Backup.
  - Used to provide guidance to users when completing a specific question within a DMP. 
* Guidance group:
  - Set of guidance offered by an organisation, funder etc.
  - Consists of one or more guidances.
* Guidance:
  - Apply to one or more themes.
  - If user has selected guidance group then when a question falling within one of those themes is presented, the guidance is also presented.
  - Theme(s)-specific. 
* Template:
  - Organisational and/or funder-specific.
  - Consists of one or more phases.
* Phase:
  - Type of DMP e.g. outline DMP for proposal, full DMP for project.
  - May be many versions.
* Version
  - Version of a phase.
  - Consists of one or more sections.
* Section:
  - Consists of one or more questions.
* Question:
  - Has 1 or more associated themes.
  - Has question-specific guidance.

We can map concepts from software management plans into the above concepts. So, using the Institute's guide on [Writing and using a software management plan](http://www.software.ac.uk/resources/guides/software-management-plans) as a source of SMP-related content:

* Themes:
  - There is no reason why SMP-related information cannot be grouped into themes, in the way that DMP-related information is.
  - Some themes from DMPs are applicable to SMPs e.g. Documentation, Discovery by Users, Ethical Issues, IPR Ownershop and Licencing etc.
* Guidance group:
  - As for DMPs, SMP guidance could be organisation or funder-specific.
  - At the outset, a single Institute guidance group can be offered.
* Guidances:
  - Theme(s)-specific guidance would be applicable to SMPs too.
* Templates:
  - As for DMPs, SMP templates could be organisational and/or funder-specific.
  - At the outset, a single Institute template can be offered.
* Phase:
  - As for DMPs, SMPs could apply at different phases of a project e.g. outline SMP for proposal, full SMP for project.
  - At the outset, a single phase can be offered.
* Version
  - Version of a phase.
  - Consists of one or more sections.
  - At the outset, a single version can be offered.
* Section:
  - These can be taken directly from the Institute guide.
    - Software assets used and produced
    - Intellectual Property and Governance
    - Access, sharing and reuse
    - Long-term preservation
    - Resourcing and responsibility
* Questions:
  - These can be taken directly from the Institute guide.

---

## Populating DMPonline data with software management plan data

Database tables to hold all this information are created by db/schema.rb. 

The database is populated via db/seeds.rb. This defines the information as presented to the user. By editing this file we can change what information is presented to user, defining templates, phases, sections, suggested answers and guidance.

---

## Don't worry about what the user can't and won't see

DMPonline's code contains myriad references to data management plans, data and DMPs. For example:

* Database table and column names. This is limited to the tables and fields:
  - dmptemplates
  - dmptemplates_guidance_groups
  - guidances.dmptemplate_id
  - phases.dmptemplate_id
  - projects.dmptemplate_id
  - users.dmponline3
* Class, function and variable names.
* File names.
* URL paths.

As these are not exposed to users, for the purposes of prototyping an SMP service they will be left as-is. There are two reasons for this:

* To reduce the time to develop the prototype.
* To limit the divergence between the SMP service code and DMPonline.

While URL paths are visible to the users, it can be assumed that these do not form part of the user's interface. However, if developing an API for developers, based upon these URLs, then renaming would be desirable.

Before altering names within database schema, code, file names or URL paths, the DCC should be consulted as it would be preferable for changes to be made within DMPonline also perhaps by, for example, abstracting away from DMPs and SMPs (e.g. using templates or plantemplates rather than dmptemplates in the database tables).

The file DesktopDMPquestions_table.sql is ignored as it is unused by the DMPonline code.

---

## Developing a prototype SMP service

### Make Shibboleth authentication user interface content configurable

Shibboleth authentication is not required for a prototype SMP service.

Shibboleth-specific user interface content is defined in config/locales/en.yml e.g.

    institution_sing_in_link: "Or, sign in with your institutional credentials"
    institution_sing_in: " (UK users only)"

    shibboleth_linked_text: "Your account is linked to your institutional credentials."
    shibboleth_to_link_text: "Link your DMPonline account to your institutional credentials"
    ...

    sign_up_shibboleth_alert_text_html: "Note: If you have previously created ..."

These allowed the associated views/ files that present this information within the user interface to be identified.

    app/views/shared/_login_form.html.erb:
    app/views/devise/registrations/edit.html.erb:
    app/views/devise/registrations/new.html.erb

As config/application.rb defines a config.shibboleth_enabled flag:

    config.shibboleth_enabled = true

_login_form.html.erb and edit.html.erb could be updated to access the value of this flag, via the reference DMPOnline4::Application.config.shibboleth_enable, and so present Shibboleth-specific content only if this flag is set to true. There was no need to update new.html.erb as that can only be accessed via the other pages.

Commit: [0bc7b24f560ea8cfaf4fa96b6cc141ca82b4818a](https://github.com/softwaresaved/smp-service/commit/0bc7b24f560ea8cfaf4fa96b6cc141ca82b4818a).

These two files were then updated to access the flag via Rails.application.config.shibboleth_enabled instead of DMPonline4::Application.config.shibboleth_enabled.

Commit: [af8d9befa11488f4adc1fbb56962b47bf77efc27](https://github.com/softwaresaved/smp-service/commit/af8d9befa11488f4adc1fbb56962b47bf77efc27).

**TODO: rebase these changes and recreate these changes into a branch of DMPonline (due to the way commits have been made elsewhere a simple rebase may be challenging) and create a pull request to DMPonline_v4. Ability to enable/disable Shibboleth content could be useful to DMPonline deployers.**

### Remove references to DMPonline 3

There are a number of references to DMPonline 3 in the code as data from DMPonline 3 can be ported to DMPonline 4 and the [DMPonline 3 service](https://dmponline3.dcc.ac.uk/) is still available to legacy users. This versioning is not applicable to a prototype SMP service.

Most DMPonline 3-related content is presented within the user interface only if the user has an associated dmponline3 flag set within the database:

    app/controllers/registrations_controller.rb:
        if existing_user.dmponline3 && (existing_user.password == "" || existing_user.password.nil?) && existing_user.confirmed_at.nil? then

    app/controllers/sessions_controller.rb:
        if !existing_user.nil? && existing_user.dmponline3 && (existing_user.password == "" || existing_user.password.nil?) && existing_user.confirmed_at.nil? then
            redirect_to :controller => :existing_users, :action => :index, :email => params[:user][:email]

    app/controllers/existing_users_controller.rb
        ...

    app/views/existing_users/index.html.erb:
        <p>Welcome to the new DMPonline!</p>

    app/views/projects/index.html.erb:
        <% if current_user.dmponline3 then %>
        <p>You can view or edit earlier plans by visiting <%= link_to("the previous version of DMPonline", "http://dmponline3.dcc.ac.uk") %>.</p>
        <p>You can view or edit earlier plans by visiting <%= link_to("the previous version of DMPonline", "http://dmponline3.dcc.ac.uk") %>.</p>

The only exceptions are links to the old DMPonline 3 service in the site-wide page footer, and in config/locales/en.yml content that is presented in the About Us and Help pages: 

    app/views/layouts/_dmponline_footer.html.erb:
        <li><a href="http://dmponline3.dcc.ac.uk/" target='_blank'><%= t('dmponline3_text') %></a></li>

    config/locales/en.yml:
        dmponline3_text: "DMPonline previous version"

    config/locales/en.yml:
        <p>If you need to access plans from the earlier version of the tool please visit <a href='https://dmponline3.dcc.ac.uk' target='_top'>DMPonline v3</a>.</p></div>"

        <h3>Legacy data</h3>
        <p>If you need to access plans from the earlier version of the tool please visit <a href='https://dmponline3.dcc.ac.uk' target='_top'>DMPonline v3</a>.</p>"

These files were updated to remove this content.

Commit: [838b5638a6a778e2f63cbb17e15fd529a5812350](https://github.com/softwaresaved/smp-service/commit/838b5638a6a778e2f63cbb17e15fd529a5812350).

**TODO: Could remove all trace of dmponline3 in future development of the SMP service, so long as SMP service is kept "downstream" of DMPonline this should be OK.**

### Change DMPonline, DMP, data management plan references in the user interface

The following name replacements in HTML fragments and Ruby strings presented within the user interface, or in e-mails, were made:

* DMPonline => Software Management Plan Service
* Data Management Plan => Software Management Plan
* DMP => SMP. 

config/locales/en.yml was *not* touched as that overlaps with institution-specific branding (see below).

Commit: [24c99223837b694784ac9ac205f518fe4d6cacdf](https://github.com/softwaresaved/smp-service/commit/24c99223837b694784ac9ac205f518fe4d6cacdf).

There 27 separate places where these replacements had to be made. Holding these values one or more configuration values would make it easier to configure the code from DMPs to SMPs and also, for those deploying DMPonline locally, to change the product name (e.g. to [DMP Builder](https://dmp.library.ualberta.ca/)).

HTML anchors in app/views/static_pages/help.html.erb were then edited to make link anchors SMP and DMP agnostic.
 
Commit: [d81af43b30a303e3f7194818b97a3a607b7197af](https://github.com/softwaresaved/smp-service/commit/d81af43b30a303e3f7194818b97a3a607b7197af).

The phrases 'access to the SMP NNNN' in the e-mail content files:

    app/views/user_mailer/permissions_change_notification.html.erb
    app/views/user_mailer/project_access_removed_notification.html.erb
    app/views/user_mailer/sharing_notification.html.erb

was then reworded to 'access to NNNN' so these files are SMP and DMP agnostic

Commit: [84da8b679cfafbfbf7c1a5120844875657c55abc](https://github.com/softwaresaved/smp-service/commit/84da8b679cfafbfbf7c1a5120844875657c55abc).

With an improved understanding of how Ruby on Rails handles internationalisation, further changes were made to allow more configuration of user interface and e-mail text to be done via config/locales/en.yml. The following properties were added to config/locales/en.yml:

    tool_product
    mail.access_granted
    mail.access_changed
    mail.access_removed
    helpers.plan.export.default_title
    helpers.shibboleth_invite_text
    helpers.shibboleth_invite_link_text

The following files were updated to use these and existing properties:

    app/controllers/projects_controller.rb
      helpers.shibboleth_invite_text
      helpers.shibboleth_invite_link_text
    app/mailers/user_mailer.rb
      mail.access_granted
      mail.access_changed
      mail.access_removed
    app/models/plan.rb
      helpers.plan.export.default_title
    app/views/devise/mailer/confirmation_instructions.html.erb
      tool_title
    app/views/devise/mailer/invitation_instructions.html.erb
      tool_title
      tool_product
    app/views/devise/mailer/reset_password_instructions.html.erb
      tool_title
    app/views/devise/mailer/unlock_instructions.html.erb
      tool_title

Commit: [b2a41e8c7119f274032ca2601e1db24835a0d629](https://github.com/softwaresaved/smp-service/commit/b2a41e8c7119f274032ca2601e1db24835a0d629).

**TODO: rebase these changes and recreate these changes into a branch of DMPonline (due to the way commits have been made elsewhere a simple rebase may be challenging) and create a pull request to DMPonline_v4. Additional configurability could be useful to those rebranding DMPonline too.**

With these changes in place, the only remaining references in the user interface to DMP or data management plan or DMPonline are within configuration files:

    config/environments/development.rb
    config/environments/production.rb
    config/initializers/active_admin.rb
    config/locales/devise.en.yml
    config/locales/en.yml
    db/seeds.rb

Or files that relate to DMPonline and Digital Curation Centre-specific branding:

    public/403.html
    public/_index.html

These will be addressed below.

### Make Google Map configurable

app/views/contact_us/contacts/new.html.erb contains a link to a GoogleMap showing the DCC:

      <iframe width="90%" height="250" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.co.uk/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=EH8+9LE&amp;aq=&amp;sll=55.85546,-4.232459&amp;sspn=0.195785,0.663986&amp;ie=UTF8&amp;hq=&amp;hnear=EH8+9LE,+United+Kingdom&amp;ll=55.944435,-3.186767&amp;spn=0.006104,0.02075&amp;t=m&amp;z=14&amp;iwloc=A&amp;output=embed"></iframe>

This has been changed to point to EPCC, The University of Edinburgh.

Commit: [66ce99ecf778ec9514f2ebced82dc26b0d9759f2](https://github.com/softwaresaved/smp-service/commit/66ce99ecf778ec9514f2ebced82dc26b0d9759f2).

As this Google Map link is the only DCC-specific part of app/views/contact_us/contacts/new.html.erb that is hard-coded, the rest of the content being provided via config/locales/en.yml, introducing a map_url configuration value removes all DCC-specific content from new.html.erb.

Commit: [2f6d48e653b53726d43880c26e16d233cd474702](https://github.com/softwaresaved/smp-service/commit/2f6d48e653b53726d43880c26e16d233cd474702).

**TODO: rebase these changes and recreate these changes into a branch of DMPonline (due to the way commits have been made elsewhere a simple rebase may be challenging) and create a pull request to DMPonline_v4. Additional configurability could be useful to those rebranding DMPonline too.**

### Remove link to DMPonline News

DMPonline has a news page accessed by a News button in every page's header. The files associated with this are:

    config/locales/en.yml
      news_label: "News"
    app/views/layouts/_dmponline_header.html.erb
      <%= link_to t('helpers.news_label'), '/news', :class => "btn header_button btn-grey"%>
    app/views/static_pages/news.html.erb
      <h2>DMPonline stories from the DCC website</h2>
      <p>Read more on the <%= link_to "DCC Website", entry.url %></p>
    app/controllers/static_pages_controller.rb
      dcc_news_feed_url = "http://www.dcc.ac.uk/news/dmponline-0/feed"

_dmponline_header.html.erb was edited to remove the link.

Commit: [6d691d6ebb7ff4d4cf823605f6734801a872875c](https://github.com/softwaresaved/smp-service/commit/6d691d6ebb7ff4d4cf823605f6734801a872875c).

This means that the news page is still available if someone views news.html directly. They would see news from the DCC as for DMPonline.

[DMP Builder](https://dmp.library.ualberta.ca) adopted a similar solution, commenting out the link with the [news.html](https://dmp.library.ualberta.ca/news.html) page still being accessible.

**TODO: Could remove all trace of News in future development of the SMP service, so long as SMP service is kept "downstream" of DMPonline this should be OK.**

### Remove screencast

There are a number of DCC, and related, videos:

    app/assets/images/screencast.jpg
    app/assets/videos/index.files/html5video/flashfox.swf
    app/assets/videos/index.files/html5video/fullscreen.png
    app/assets/videos/index.files/html5video/screencast.jpg
    app/assets/videos/index.files/html5video/screencast.m4v
    app/assets/videos/index.files/html5video/screencast.mp4
    app/assets/videos/index.files/html5video/screencast.ogv
    app/assets/videos/index.files/html5video/screencast.webm

These are used within app/views/home/index.html.erb:

    <video controls="controls" poster="<%= asset_path('screencast.jpg')%>" style="width:100%; height:200" title="1662">
    <source src="<%= asset_path('index.files/html5video/screencast.mp4')%>" type="video/mp4" />
    <source src="<%= asset_path('index.files/html5video/screencast.webm')%>" type="video/webm" />
    <source src="<%= asset_path('index.files/html5video/screencast.ogv')%>" type="video/ogg" />
    <param name="flashVars" value="autoplay=true&amp;controls=true&amp;fullScreenEnabled=true&amp;posterOnEnd=true&amp;loop=false&amp;poster=<%= asset_path('screencast.jpg')%>&amp;src=<%= asset_path('index.files/html5video/screencast.mp4')%>" />
    <embed src="<%= asset_path('index.files/html5video/flashfox.swf')%>" width="100%" height="200" style="position:relative;"  flashVars="autoplay=true&amp;controls=true&amp;fullScreenEnabled=true&amp;posterOnEnd=true&amp;loop=false&amp;poster=<%= asset_path('screencast.jpg')%>&amp;src=<%= asset_path('index.files/html5video/screencast.mp4')%>"	allowFullScreen="true" wmode="transparent" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer_en" />
    <img alt="screencast" src="<%= asset_path('screencast.jpg')%>" style="position:absolute;left:0;" width="100%" title="<%= t('screencast_error_text')%>" />

indes.html.erb was edited to remove screencast.

Commit: [820ef77e150d93f1bcdcb87db78373b910534f28](https://github.com/softwaresaved/smp-service/commit/820ef77e150d93f1bcdcb87db78373b910534f28).

The video files are still present, for now.

**TODO: Could remove all trace of these videos in future development of the SMP service, so long as SMP service is kept "downstream" of DMPonline this should be OK. Alternatively, update the screencast with an SMP service-specific one.**

### Resolve Export as docx and htmltoword 0.2.0 gem issue

Exporting as a Word document (docx) raised the error:

    No such file or directory - /disk/ssi-dev0/home/mjj/.rvm/gems/ruby-2.0.0-p247/gems/htmltoword-0.2.0/lib/htmltoword/xslt/html_to_wordml.xslt    

Looking at the gem on both SL6, and a fresh Ruby and gem install under an Ubuntu server, showed there was no xslt file e.g. for Ubuntu:

    $ ls /var/lib/gems/1.9.1/gems/htmltoword-0.2.0/lib/
    lib  Rakefile  README.md    $ ls /var/lib/gems/1.9.1/gems/htmltoword-0.2.0/lib/htmltoword
    action_controller.rb  document.rb           version.rb
    configuration.rb      htmltoword_helper.rb

However, the [0.2.0 tag](https://github.com/nickfrandsen/htmltoword/tree/v0.2.0/lib/htmltoword/xslt) on GitHub and the [0.2.0 zip](https://github.com/nickfrandsen/htmltoword/archive/v0.2.0.zip) both have htmltoword-0.2.0/lib/htmltoword/xslt with the xslt file.

Trying with the previous version, 0.1.8, gives:

    $ ls /var/lib/gems/1.9.1/gems/htmltoword-0.1.8/xslt/
    html_to_wordml.xslt  style2.xslt

Updating the DMPonline Gemfile to specifically use 0.1.8

    gem 'htmltoword', '0.1.8'

and running:

    $ bundle update

sorted this problem.

Another user of htmltoword 0.2.0 has raised this as an [issue](https://github.com/nickfrandsen/htmltoword/issues/33).

Commit: [3ddd70fa0f68e7fecb9ce0463d3ab4b84ca73ecc](https://github.com/softwaresaved/smp-service/commit/3ddd70fa0f68e7fecb9ce0463d3ab4b84ca73ecc)

**TODO: recreate this change into a branch of DMPonline.**

### Resolve flash not showing for reCAPTCHA failures

If the user does not enter a valid reCAPTCHA then no message is displayed. The problem seemed to be with app/controllers/contacts_controller.rb which sets flash values with the key :error. According to the Rails documentation on the [flash](http://guides.rubyonrails.org/action_controller_overview.html#the-flash), only :notice and :alert are supported:

> Note that it is also possible to assign a flash message as part of the redirection. You can assign :notice, :alert or the general purpose :flash:

Changing :error to :alert solves this problem.

Commit: [d550325c55b40fa0d8a1319d65a25ddf9559d10a](https://github.com/softwaresaved/smp-service/commit/d550325c55b40fa0d8a1319d65a25ddf9559d10a)

**TODO: recreate this change into a branch of DMPonline.**

### Update branding

config/locales/en.yml contains text used within numerous places throughout the user interface to provide context and built-in help for using DMPonline, as well as background about DMPonline, and links to other resources. This file has been updated to reflect a prototype SMP service, developed by The Software Sustainability Institute, hosted at The University of Edinburgh, powered by DMPonline. This includes changes to URLs and e-mails:

    config/locales/en.yml
      generated_by: This document was generated by DMPonline (http://dmponline.dcc.ac.uk)
      <a href='mailto:dmponline@dcc.ac.uk?Subject=DMPonline%20inquiry' target='_top'>dmponline@dcc.ac.uk</a>. You can also report bugs and request new features directly on <a href='https://github.com/DigitalCurationCentre/DMPonline_v4' target='_top'>GitHub</a></p>
      intro_text_html: "<p>DMPonline is provided by the Digital Curation Centre. You can find out more about us on our <a href='http://www.dcc.ac.uk/' target='_blank'>website</a>. If you would like to contact us about DMPonline, please enter your query in the form below or email <a href='mailto:dmponline@dcc.ac.uk?Subject=DMPonline%20inquiry' target='_top'>dmponline@dcc.ac.uk</a>.</p>"
      <p>Email <a href='mailto:dmponline@dcc.ac.uk?Subject=DMPonline%20inquiry' target='_top'>dmponline@dcc.ac.uk</a></p>"

Commit: [bd65b4873644c2614e9097be1ba53821d6bc50da](https://github.com/softwaresaved/smp-service/commit/bd65b4873644c2614e9097be1ba53821d6bc50da).

Removed port number from URL in generated_by value:

Commit [926c58ff3d752a31733c4393696bc2c64888ad65](https://github.com/softwaresaved/smp-service/commit/926c58ff3d752a31733c4393696bc2c64888ad65)

Added information on why we developed the service and disclaimers to config/locales/en.yml, and an alert flash to app/views/layouts/application.html.erb:

    <p class="alert alert-notice">Please be aware this is a prototype service. Data may be lost or errors might occur. Thank you. </p>			

Commit: [06e753e4b41d9088d5036acb57366ee24364b102](https://github.com/softwaresaved/smp-service/commit/06e753e4b41d9088d5036acb57366ee24364b102)

There are additional references to URLs, e-mail addresses etc. that deployers should change to reflect a local deployment of DMPonline which includes the following...

public/403.html provides a contact e-mail if problems arise:

      <p>To report this error please contact us on <a href='mailto:dmponline@dcc.ac.uk'>dmponline@dcc.ac.uk</a></p>

This has been (temporarily) updated to my e-mail address. 

Commit: [ded693cae486fe84efdc43edce6b6a4e0bd4bb41](https://github.com/softwaresaved/smp-service/commit/ded693cae486fe84efdc43edce6b6a4e0bd4bb41). Removed redundant quote symbol [5c645a327b3e16ec60141a00347da4b1bb4193e1](https://github.com/softwaresaved/smp-service/commit/5c645a327b3e16ec60141a00347da4b1bb4193e1).

This file is used if Ruby on Rails is down for some reason and can be served up by a web server:

    public/_index.html
      <p>For more information please visit <a href="www.dcc.ac.uk">DCC website</a></p>
      <p><img src="http://dmponline-beta.dcc.ac.uk/assets/logo-0ec5a8a171db942f9b452733c53d3263.jpg" /> will be back soon.</p>
      src: url('http://dmponline-beta.dcc.ac.uk/assets/GillSansLight-559cc79d847cc0364fd43d2f4766d6ed.ttf') format('truetype');

This page shows a broken image link and the text:

    will be back soon.

    For more information please visit DCC website

This has been updated to be consistent in appearence and content to public/403.html. This also removes dependence on the external img resources that it linked to. This (temporarily) refers to my e-mail address. 

Commit: [bd14437b7edea5ff154eb753c06fd9dd66d9323e](https://github.com/softwaresaved/smp-service/commit/bd14437b7edea5ff154eb753c06fd9dd66d9323e).

403.html and _index.html have since been updated to cite info@software.ac.uk [3a75c77f2d88bcd2dd77a9cf529b63a34e41b3c9](https://github.com/softwaresaved/smp-service/commit/3a75c77f2d88bcd2dd77a9cf529b63a34e41b3c9).

app/views/layouts/_dmponline_footer.html.erb has a copyright statement and link:

      <p id="dcc_link">&copy; 2004 - <%= Time.now.year %><%= link_to ' Digital Curation Centre (DCC)', 'http://www.dcc.ac.uk'%>

This has been extended to include The University of Edinburgh as copyright holder for 2015 content.

Commit: [e0c804e5dc87213fb6e4a686801d588df4817885](https://github.com/softwaresaved/smp-service/commit/e0c804e5dc87213fb6e4a686801d588df4817885).

The DCC-specific stylesheet:

    app/assets/stylesheets/bootstrap_and_overrides.css.less 

and public/_index.html and public/403.html customised for consistency with SSI colors:

* White background
* Black headings and text
* Red hyperlinks, which are underlined when the cursor hovers over them
* Red menu bars and menu items
* White menu bar and item text
* Black selected menu items

I found [HTML Color Codes](http://html-color-codes.info/) useful in determining existing colours.

Commit: [5cd58d0c073fd4fa4ed2593c36bae7abe70506f1](https://github.com/softwaresaved/smp-service/commit/5cd58d0c073fd4fa4ed2593c36bae7abe70506f1).

There are issues with some styles having colours within their names:

    a.a-orange.hover
    hr.orange_break_line
    .btn-grey and variants
    .white_background

There are also some embedded colours:

    #error_explanation {
      border: 2px solid red;

      background-color: #f0f0f0;

      h2 {
        background-color: #c00;
        color: #fff;
    }

It is time consuming to update all the styles as the whole of DMPonline must be explored to ensure nothing has been missed.

There was a lingering orange in "Not Answered" tags (Orange #f89406) which looks similar to DCC branding. However, this was a [Twitter Bootstrap Label](http://cssdeck.com/labs/twitter-bootstrap-labels).

There also DCC-style orange-branded icons:

    app/assets/images/download.png
    app/assets/images/minus_laranja.png
    app/assets/images/plus_laranja.png
    app/assets/images/question-mark.png

These do not seem to be used in DMPonline.

There are a number of DCC, and related, logos:

    app/assets/images/dcc_logo.png
    app/assets/images/dmponline_favicon.ico
    app/assets/images/logo.jpg
    app/assets/images/2013_Jisc_Logo_RGB72.png

The relevant files need to be updated to hide these images or media, or present new SMP-specific ones, to the users:

    app/views/layouts/_dmponline_footer.html.erb
      <p><%= link_to( image_tag('dcc_logo.png', :class => 'footer_logo'), 'http://www.dcc.ac.uk/', :id => 'footer_right_dcc')%>
      <%= link_to( image_tag('2013_Jisc_Logo_RGB72.png', :class => 'footer_logo'), 'http://www.jisc.ac.uk/', :id => 'footer_right_jisc')%></p>
    app/views/layouts/_dmponline_header.html.erb
      <%= link_to( image_tag('logo.jpg'), root_path)%>
    app/views/layouts/application.html.erb
      <%= favicon_link_tag 'dmponline_favicon.ico' %>

The DCC and DMPonline logo should be presented in an SMP service, with a 'powered by DMPonline' statement and associated web-links.

A new app/assets/images/logo.png with the SSI logo was added as was a smaller version of the DMPonline logo, DMPonlineLogo.jpg. _dmponline_header_html.erb and _dmponline_footer_html.erb were updated to show the SSI logo in the header, with a "Software Management Plan Service" title (from config/locales/en.yml) and to show "Powered by" and the DMPonline and DCC logos in the footer.

Commit:[db7feaa994a7f9ada433edb12b59c3b3c44b4b21](https://github.com/softwaresaved/smp-service/commit/db7feaa994a7f9ada433edb12b59c3b3c44b4b21).

Updated public/favicon.ico with SSI favicon.ico.

Commit: [7e5180c032bd889a45f9a58056e676465a862a47](https://github.com/softwaresaved/smp-service/commit/7e5180c032bd889a45f9a58056e676465a862a47)

Added app/assets/images/favicon.ico, copy of favicon.ico.

Commit: [683250843fccafb308e240b4ff6b733b77f5f02e](https://github.com/softwaresaved/smp-service/commit/683250843fccafb308e240b4ff6b733b77f5f02e)

Updated app/views/layouts/application.html.erb:

    <%= favicon_link_tag 'dmponline_favicon.ico' %>

with:

    <%= favicon_link_tag 'favicon.ico' %>

Commit: [0e29256e38486ea86342dcaa461cdccc04594d5b](https://github.com/softwaresaved/smp-service/commit/0e29256e38486ea86342dcaa461cdccc04594d5b)

**TODO: DMPonline should use this generic icon name to make rebranding easier.**





### Don't commit local configuration changes that are provided by deployers

There are a number of places where DMPonline specifies e-mail addresses, URLs, public and private keys, host names etc. Some of these values relate to configuration and which need to be changed by a deployer for DMPonline to run locally. These are:

    app/mailers/user_mailer.rb
       default from: 'info@dcc.ac.uk'
    config/application.rb
      config.action_mailer.default_url_options = { :host => 'dmponline.example.com' }
      :exe_path => '/usr/local/bin/wkhtmltopdf'
    config/environments/development.rb
      config.action_mailer.default_url_options = { :host => 'localhost:3000' }
      config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
      ActionMailer::Base.default :from => 'address@example.com'
      ActionMailer::Base.smtp_settings = { :address => "localhost", :port => 1025 }
      :sender_address => %{"No-reply" <noreply@dcc.ac.uk>},
      :exception_recipients => %w{dmponline@dcc.ac.uk}
    config/environments/production.rb
      sender_address => %{"No-reply" <noreply@dcc.ac.uk>},
      :exception_recipients => %w{dmponline@dcc.ac.uk}
    config/initializers/contact_us.rb
      config.mailer_to = "dmponline@dcc.ac.uk"
    config/initializers/devise.rb
     config.mailer_sender = "info@dcc.ac.uk"
     config.pepper = "de451fa8d44af2c286d922f753d1b10fd23b99c10747143d9ba118988b9fa9601fea66bfe31266ffc6a331dc7331c71ebe845af8abcdb84c24b42b8063386530"
    config/initializers/secret_token.rb
      DMPonline4::Application.config.secret_token = '4eca200ee84605da3c8b315a127247d1bed3af09740090e559e4df35821fbc013724fbfc61575d612564f8e9c5dbb4b83d02469bfdeb39489151e4f9918598b2'
    config/initializers/recaptcha.rb
      config.public_key  = 'replace_this_with_your_public_key'
      config.private_key = 'replace_this_with_your_private_key'

If using Shibboleth then the deployer also needs to configure:

    config/application.rb
      config.shibboleth_login = 'https://localhost/Shibboleth.sso/Login'

For the prototype SMP service, therefore, no changes will be commited for these files and file updates will be held privately.
