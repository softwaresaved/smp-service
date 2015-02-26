
# Customing DMPonline into a prototype SMP service

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 26/02/2014.

## Introduction

This document notes the main changes that need to be made, and have been made, to [DMPonline](https://github.com/DigitalCurationCentre/DMPonline_v4) to use it as a prototype service for software management plans.

The version of DMPonline used as a basis of this document was the latest at the time of writing, master branch, commit [6236385f55189be55f2b470b5ee3563615d964c1](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/6236385f55189be55f2b470b5ee3563615d964c1) 24 Nov 2014.

The prototype SMP service is in the [smp-prototype](https://github.com/softwaresaved/smp-service/tree/smp-prototype) branch of the [smp-service](https://github.com/softwaresaved/smp-service) repository.

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

### DMPonline presentation

The following name replacements in HTML fragments and Ruby strings presented within the user interface, or in e-mails, were made:

* DMPonline => Software Management Plan Service
* Data Management Plan => Software Management Plan
* DMP => SMP. 

config/locales/en.yml was *not* touched as that overlaps with institution-specific branding (see below).

The changes are in commit [24c99223837b694784ac9ac205f518fe4d6cacdf](https://github.com/softwaresaved/smp-service/commit/24c99223837b694784ac9ac205f518fe4d6cacdf).

There 27 separate places where these replacements had to be made. Holding these values one or more configuration values would make it easier to configure the code from DMPs to SMPs and also, for those deploying DMPonline locally, to change the product name (e.g. to [DMP Builder](https://dmp.library.ualberta.ca/)).

---

### Shibboleth authentication

Shibboleth authentication is not required for a prototype SMP service.

Shibboleth-specific user interface content is defined in config/locales/en.yml. These allowed the associated views/ files that present this information within the user interface to be identified.

app/views/shared/_login_form.html.erb - login form on the DMPonline home page:

    institution_sing_in_link: "Or, sign in with your institutional credentials"
    institution_sing_in: " (UK users only)"

app/views/devise/registrations/edit.html.erb - Edit Profile page:

    shibboleth_linked_text: "Your account is linked to your institutional credentials."
    shibboleth_to_link_text: "Link your DMPonline account to your institutional credentials"
    shibboleth_unlink_label: "Unlink your institutional credentials"
    shibboleth_unlink_alert: "Unlink institutional credentials alert"
    shibboleth_unlink_dialog_text: "<p>You are about to unlink DMPonline of your institutional credentials, would you like to continue?</p>"

app/views/devise/registrations/new.html.erb - callback page when user returns from Shibboleth service:

    sign_up_shibboleth_alert_text_html: "Note: If you have previously created an account in DMPonline, and you want to link this to your institutional credentials, you need to <a href='/' class='a_orange'>Sign in</a> to that existing DMPonline account first. If you have never created a DMPonline account, then please complete the form below."

As config/application.rb defines a config.shibboleth_enabled flag:

    config.shibboleth_enabled = true

_login_form.html.erb and edit.html.erb were updated to present Shibboleth-specific content only if this flag is set to true. There was no need to update new.html.erb as that can only be accessed via the other pages.

The changes are in commit [0bc7b24f560ea8cfaf4fa96b6cc141ca82b4818a](https://github.com/softwaresaved/smp-service/commit/0bc7b24f560ea8cfaf4fa96b6cc141ca82b4818a).

### DMPonline 3

There are a number of references to DMPonline 3 in the code as data from DMPonline 3 can be ported to DMPonline 4 and the DMPonline 3 service is still live for legacy users. This is not applicable to a prototype SMP service.

Most DMPonline 3-related content is presented within the user interface only if the user has an associated dmponline3 flag set within the database:

    app/controllers/registrations_controller.rb:
        if existing_user.dmponline3 && (existing_user.password == "" || existing_user.password.nil?) && existing_user.confirmed_at.nil? then
        ...

    app/controllers/sessions_controller.rb:
        if !existing_user.nil? && existing_user.dmponline3 && (existing_user.password == "" || existing_user.password.nil?) && existing_user.confirmed_at.nil? then
            redirect_to :controller => :existing_users, :action => :index, :email => params[:user][:email]

    app/controllers/existing_users_controller.rb

    app/views/existing_users/index.html.erb:
        ...
        <p>Welcome to the new DMPonline!</p>
        ...

    app/views/projects/index.html.erb:
        <% if current_user.dmponline3 then %>
        <p>You can view or edit earlier plans by visiting <%= link_to("the previous version of DMPonline", "http://dmponline3.dcc.ac.uk") %>.</p>
        <p>You can view or edit earlier plans by visiting <%= link_to("the previous version of DMPonline", "http://dmponline3.dcc.ac.uk") %>.</p>
        ...

The only exceptions are links to the old DMPonline 3 service in the footer:

    app/views/layouts/_dmponline_footer.html.erb:
        <li><a href="http://dmponline3.dcc.ac.uk/" target='_blank'><%= t('dmponline3_text') %></a></li>

    config/locales/en.yml:
        dmponline3_text: "DMPonline previous version"

And in the /about_us and /help pages, where the content is defined in:

    config/locales/en.yml:
        <p>If you need to access plans from the earlier version of the tool please visit <a href='https://dmponline3.dcc.ac.uk' target='_top'>DMPonline v3</a>.</p></div>"

        <h3>Legacy data</h3>
        <p>If you need to access plans from the earlier version of the tool please visit <a href='https://dmponline3.dcc.ac.uk' target='_top'>DMPonline v3</a>.</p>"

These files were updated to remove this content. The changes are in commit [838b5638a6a778e2f63cbb17e15fd529a5812350](https://github.com/softwaresaved/smp-service/commit/838b5638a6a778e2f63cbb17e15fd529a5812350).

---

## DMPonline branding - WIP

There are a number of DCC and DMPonline-specific images and other media including logos, icons, stylesheets and branding.

config/locales/en.yml contains text used within numerous places throughout the user interface to provide context and built-in help for using DMPonline, as well as background about DMPonline, contact information and links to other resources. This file has been updated to reflect a prototype SMP service, developed by The Software Sustainability Institute, hosted at The University of Edinburgh, powered by DMPonline.

The changes are in commit [bd65b4873644c2614e9097be1ba53821d6bc50da](https://github.com/softwaresaved/smp-service/commit/bd65b4873644c2614e9097be1ba53821d6bc50da).

TODO

[code-branding.txt](./code-branding.txt) lists these and their usage. 

The relevant views/ files need to be updated to hide these images or media, or present new SMP-specific ones, to the users.

The DCC and DMPonline logo should be presented in an SMP service, with a 'powered by DMPonline' statement and associated web-links.

In addition, config/locales/en.yml needs to be updated with SMP-specific and Software Sustainability Institute-specific content.

---

### DMPonline configuration

There are a number of places where DMPonline needs to be configured with local URLs, e-mail addresses etc. These are listed in [code-local-configuration.txt](./code-local-configuration.txt) divided up into those that are needed for DMPonline to work, those relating to branding (e.g. links to further information), those supporting DMPonline 3 legacy users and those for Shibboleth.

Of these only the core and branding-related configuration needs to be customised for local deployments.

---

## Evaluating the prototype 

In any evaluation, users should be asked to inform us of any stray references to DMPs or data management plans that may have slipped through.
