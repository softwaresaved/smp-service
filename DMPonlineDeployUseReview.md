
# DMPonline deployment and usage experiences

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 25/02/2014.

## Introduction

Experiences in deploying and using DMPonline, between 19/01/14 and 16/02/14.

---

## Deploying DMPonline

Comments and questions arising from deploying DMPonline from GitHub:

* https://github.com/DigitalCurationCentre/DMPonline_v4
 
The version used was the latest at the time of writing, master branch, commit [6236385f55189be55f2b470b5ee3563615d964c1](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/6236385f55189be55f2b470b5ee3563615d964c1) 24 Nov 2014.

### Environment

The environment was:

* Scientific Linux release 6.5 (Carbon)
* Ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-linux]
* RVM 1.26.10 (latest)
* Rails 3.2.13
* MySql Ver 14.14 Distrib 5.1.73, for redhat-linux-gnu (x86_64)

The above tools under Ubuntu Desktop 14.04.1 LTS were also used.

### Deployment

Remove the `<tt>` from the command-line fragments in [README.rdoc](https://github.com/DigitalCurationCentre/DMPonline_v4/blob/master/README.rdoc).

README.rdoc states that:

*This is just the application code, the accompanying question data available at dmponline.dcc.ac.uk is not included.*

But there is question data provided, in seeds.rb.

Information on how to deploy DMPonline is distributed between:

* README.rdoc
* [Local Installation](https://github.com/DigitalCurationCentre/DMPonline_v4/wiki/1.-Local-Installation) wiki page.

These are inconsistent e.g. the wiki page recommends MySQL server v5.1+, README.rdoc recommends 5.0+. README.rdoc does not mention the need for wkhtmltopdf that is a prerequisite listed on the wiki page. A problem with wikis is that it can be hard to tell which version of any software the wiki pages relate to ... keeping the documentation within Git would reduce the risk of them diverging.

Provide a list of all the yum/apt-get installs needed since both README.rdoc and Ruby on Rails documentation are missing some (e.g. nodejs).

Document how to create a secret token e.g. from this [blog post](http://www.jamesbadger.ca/2012/12/18/generate-new-secret-token/):

    $ irb
    2.2.0 :001 > require 'securerandom'
     => true 
    2.2.0 :002 > SecureRandom.hex(64)
     => "bfe98e994ee0416218f638f1fd2f4b8857e63fcd6f6bd3c2b6df25fd5b5362efe3ed90fd6624ddcda9cd90b98ebe42a0d44d0c0b4f41396d2ba56d9476602ee1" 
    2.2.0 :003 > 

Alternatively:

    $ rake secret

Describe what the 'pepper' is, a "random string unique to application appended to password before hashing".

Local Installation wiki page states that:

*If wkhtmltopdf is not installed to /usr/local/bin/wkhtmltopdf then you will need to edit the config value in config/initializers/wicked_pdf.rb*

The file to update is now config/application.rb.

Local Installation wiki page states that:

*NOTE - there seems to be an issue with the latest seeds file, so please use https://github.com/DigitalCurationCentre/DMPonline_v4/blob/6791c19e751560ac9a18d3bb80f8ff21bc31ff39/db/seeds.rb instead.*

It would be preferable just to add this seeds.rb file to Git so the user does not have to do this additional, manual, task.

There is a risk of divergence here since there is a later version of seeds.rb (commit [AHRC Template](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/419adebe0f01877f78984d4e3c64168dd4565019) of [seeds.rb](https://raw.githubusercontent.com/DigitalCurationCentre/DMPonline_v4/419adebe0f01877f78984d4e3c64168dd4565019/db/seeds.rb)) which also works with the current version of DMPonline.

Provide troubleshooting information e.g. what the user may see if they forget to yum/apt-get install a package, they don't copy seeds.rb, or they have the wrong version of Ruby.

If the user runs `rake db:setup` then the existing database tables are recreated. The user should be warned about this in the user doc.

Add documentation on how to make a user an organisational admin and a site admin.

It is unclear, at present, to new deployers how to get started using their deployment. A sample template and question set configured and ready for use would provide deployers with a head start.

In addition/or alternatively, how to use the admin or super-admin interfaces to populate a deployment which has no funders, organisations, templates or questions defined would also be useful.

### Problems when creating a plan

After following the above and creating a user, I could log in and create a plan. However there are missing features. I did:

* Click Create plan
* Select Funder: Not applicable/not listed
* Select Organisation: Not applicable/not listed
* Select DCC guidance
* Click select here to write a generic DMP
* Click Yes, create plan

The following were missing from projects/my-plan-dcc-template:

* Plan details tab:content beneath "This plan is based on:" e.g. Answer questions and Export buttons and Sections and Questions.
* Generic DMP tab.
* Export tab: formats list, Export button and Settings.

These are present if following these steps using the [DMPonline test server](https://dmponline-test.dcc.ac.uk/).

Looking at the page sources for projects/my-plan-dcc-template gave, for my deployment:

    <div id="project-tabs" class="nav-project-tabs">
	<ul class="nav nav-tabs" data-tabs="tabs">
		<!-- Project details (views/projects/_project_details.html.erb)-->
			<li class="active">
		<a href="/projects/my-plan-dcc-template">Plan details</a>
	   		</li>
    <!-- Plans (phases)-->
    <!--Share project (project admin only)-->

    ...

	<h3>This plan is based on:</h3>
	<table class="dmp_details_table">
		<!-- get the funder name if there is one -->
	</table>
			
	<!-- If project has plans-->
				
				<div class="move_2_right">
					<a href="/projects/my-plan-dcc-template--46/plans/1950/edit" class="btn btn-primary">Answer questions</a>
					<a href="#1950-export-dialog" data-toggle="modal" class='btn btn-primary'>Export</a>
				</div>

For DMPonline test server:

    <div id="project-tabs" class="nav-project-tabs">
	<ul class="nav nav-tabs" data-tabs="tabs">
		<!-- Project details (views/projects/_project_details.html.erb)-->
			<li class="active">
		<a href="/projects/my-plan-dcc-template--46">Plan details</a>
	   		</li>
    <!-- Plans (phases)-->
			<li>http://www.knowledge.scot.nhs.uk/caldicottguardians/national-scrutiny.aspx
			<a href="/projects/my-plan-dcc-template--46/plans/1950/edit">Generic DMP</a>
		</li>
    <!--Share project (project admin only)-->

    ...

	<h3>This plan is based on:</h3>
	<table class="dmp_details_table">
		<!-- get the funder name if there is one -->
	</table>
			
	<!-- If project has plans-->

Looking at app/views/projects/_project_nav_tabs.html.erb, there is a loop which determines whether the Generic DMP tab is shown:

    <!-- Plans (phases)-->
    <% project.plans.each do |plan| %>

I edited the page and added, at the top:

    <p>project: <%= project %></p>
    <p>project.name: <%= project.name %></p>
    <p>project.plans: <%= project.plans %></p>

The page showed:

    project: #&lt;Project:0x00000009ad6250&gt;
    project.name: My plan (DCC Template)
    project.plans: []

MySQL listed no plans:

    > use dmpdev4;
    > select * from plans;
    Empty set (0.00 sec)

I inserted an entry into plans:

    > insert into plans values(1,NULL,1,1,"2014-01-01 14:00","2014-01-01 14:00");

with the project_id and version_id values deduced from the corresponding entries in projects and versions tables.

Refreshing the page showed the DCC Template tab. This differs from the DMPonline test server which names the tab Generic DMP.

Clicking the DCC Template tab showed a tab that had no content.

I tried every version of DMPonline from the current version, 6236385f55189be55f2b470b5ee3563615d964c1 Mon Nov 24 18:27:18 2014, back to 3496975ffed4e4908e268945988a124cd957e4fc Fri Jul 25 10:27:44 2014, with no success.

I added myself as a super-admin and experimented with the super-admin area:

* Select Templates Management => Section
* Click New Section
* Title: SSI
* Number: 1
* Version: DCC Template Version 1
* Organisation: Digital Curation Centre
* Description: SSI advice section
* Click Create Section

Once added, the section was visible under the Plan details and DCC Template tabs.

* Select Templates Management => Question
* Click New Question
* Text: What is your SMP
* Number: 1
* Section: DCC Template - SSI
* Select question format: Text field
* Themes: None
* Click Create Question

Once added, question was visible under the DCC Template tab.

I noticed that for all existing sections the Organisation name was undefined.

From looking at the data model, in both the database and db/seeds.rb, questions belong to sections which belong to a version of a phase which makes up a template. Both templates and sections can have associated organisations and it looks like if these are out-of-synch then problems arise (I return to this shortly).

For each section I changed the organisation from undefined to Digital Curation Centre to be consistent with the organisation of the template to which they belonged:

* Select Templates Management => Sections
* Click Data Collection Edit
* Select Organisation: Digital Curation Centre
* Click Update Section

Once done, the sections became visible under the Plan details tab but clicking the DCC Template tab gave an error:

    Extracted source (around line #17):
    
    17:                 <% if q_format.title == t("helpers.checkbox") || q_format.title == t("helpers.multi_select_box") || q_format.title == t("helpers.radio_buttons") || q_format.title == t("helpers.dropdown") then%>

So I looked at the questions associated with that section.

* Select Templates Management => Question
* Click What data will you collect or create? Edit

Each question format was empty and, given the nature of the error message, this seemed to be the likely cause. So, for each, I specified a question format:

* Select question format: Text area
* Click Update question

The DCC template tab could again be viewed.

DCC Template showed the questions which I could complete and export.

When I tried to create a new plan, the same problem as at the outset arose i.e. missing Plan detals content, missing DCC template tab and missing Export formats. Again, these could be resolved by manually inserting an entry into the plan table.

I sought out the code responsible for creating a new project. app/controllers/projects_controller.rb handles the /project/new command:

    # GET /projects/new
    # GET /projects/new.json
    def new
            if user_signed_in? then
                    @project = Project.new

app/models/project.rb defines the Project class:

    class Project < ActiveRecord::Base

        after_create :create_plans

        def create_plans
                dmptemplate.phases.each do |phase|
                        latest_published_version = phase.latest_published_version
                        unless latest_published_version.nil?
                                new_plan = Plan.new
                                new_plan.version = latest_published_version
                                plans << new_plan
                        end
                end
        end
end

Printing the value of phase, latest_published_version and latest_published_version.nil? within the loop, and the value of plans on exit, gave:

    DCC Template

    true
    []

As the problem seemed to be with the published version, I checked out whether any versions were published using the super-admin interface:

* Select Templates management => Version
* Click DCC Template Version 1 Edit

Published was unchecked, so:

* Check Published 
* Click Update Version

On creating a plan now, the output from the print statements was:

    DCC Template
    DCC Template Version 1
    false
    [#<Plan id: 3, locked: nil, project_id: 11, version_id: 1, created_at: "2015-02-16 15:36:13", updated_at: "2015-02-16 15:36:13">]

A new entry had also been created in the plans table in the database.

These issues can be fixed by editing db/seeds.rb. organisations have a name and abbreviation e.g.

    organisations = {
      'DCC' => {
        name: "Digital Curation Centre",
        abbreviation: "DCC",
        sort_name: "Digital Curation Centre",
        organisation_type: "Organisation"
      },

Sections refer to the organisation e.g.

    sections = {
      "Data Collection" => {
        title: "Data Collection",
        number: 1,
        description: "...",
        version: "DCC Template Version 1",
        organisation: "DCC"
      },
      ...
    }

These are initialised via:

    sections.each do |s, details|
      section = Section.new
      section.organisation = Organisation.find_by_name(details[:organisation])
      ...
    end

which means the organisation is not found since, for example, there is no organisation with name "DCC". Changing the initialisation to search on an organisation's abbreviation:

      section.organisation = Organisation.find_by_abbreviation(details[:organisation])

causes the sections to be correctly associated with their organisations.

Versions are initialised in a similar way e.g.

    versions = {
      "DCC" => {
        title: "DCC Template Version 1",
        number: 1,
        phase: "DCC Template"
      },
      ...
    }

    versions.each do |v, details|
      version = Version.new
      version.title = details[:title]
      ...
    end

The versions can be set to inherit the published status of their template by adding the line:

    version.published = Phase.find_by_title(details[:phase]).dmptemplate.published

Questions are initialised likewise:

    questions = {
      "What data will you collect or create?" => {
        text: "What data will you collect or create?",
        section: "Data Collection",
        number: 1,
        guidance: "....",
        themes: ["Existing Data", "Data Volumes", "Data Type", "Data Format"],
        format: "Text area"
      },
      ...
    }

    questions.each do |q, details|
      question = Question.new
      question.text = details[:text]
      ...
    end

Adding an entry:

    format: "Text area"

to each question and adding the following initialisation code:

    question.question_format = QuestionFormat.find_by_title(details[:format])

allows the question formats to be initialised.

I've produced an example of a fixed version of [db/seeds.rb](https://github.com/softwaresaved/smp-service/blob/065fbd33b758e9b952e2e02cce97f59cb5a4c7b1/db/seeds.rb).

### Problems when using organisational admin interface

Using a fresh instance of the database, I tried the organisational admin interface.

* Click Templates
* Click Create a template
* Title: My template
* Click Save
* Click Add new phase:
* Title: Solo phase
* Click Save

This gave an error:

    ArgumentError in Dmptemplates#admin_phase

    Showing /disk/ssi-dev0/home/mjj/DMPonline_v4/app/views/dmptemplates/_add_question.html.erb where line #70 raised:

    wrong number of arguments (4 for 5)
    Extracted source (around line #70):

    67: 							</tbody>
    68: 							
    69: 						</table>
    70: 						<%= link_to_add_object t('org_admin.add_option_label'), f, :options , ''%>	
    71: 					</div>
    72: 					<div class="clearfix"></div>	
    73: 					<!--display for default value for text field label-->
    Trace of template inclusion: app/views/dmptemplates/_edit_section.html.erb, app/views/dmptemplates/admin_phase.html.erb

### Code

What is DesktopDMPquestions_table.sql for? It creates a questions table whose schema differs from that of the one created by db:setup e.g.

* DesktopDMPquestions_table.sql defines a suggested_answer field.
* db:setup defines is_expanded, is_text_field, question_format_id fields.

### Back-up and restore

Document how users can back-up and restore their deployment e.g. Git can be used for DMPonline configuration files, and mysqldump for MySQL.

### Backwards compatibility policy

There should be a process for backwards compatibility and upgrades. For example, users should be warned if the database schema is going to be changed. Scripts should be provided to update their existing databases to conform to the new schema.

### Manual configuration

There are a significant number of places where the user has to provide local configuration options. Leaving aside changing the branding of DMPonline, at a minimum, the files/lines that need edited include:

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

    config/initializers/contact_us.rb
      config.mailer_to = "dmponline@dcc.ac.uk"

    config/initializers/devise.rb
     config.mailer_sender = "info@dcc.ac.uk"
     config.pepper = "de451fa8d44af2c286d922f753d1b10fd23b99c10747143d9ba118988b9fa9601fea66bfe31266ffc6a331dc7331c71ebe845af8abcdb84c24b42b8063386530"

    config/initializers/secret_token.rb
      DMPonline4::Application.config.secret_token = '4eca200ee84605da3c8b315a127247d1bed3af09740090e559e4df35821fbc013724fbfc61575d612564f8e9c5dbb4b83d02469bfdeb39489151e4f9918598b2'

It might be preferable to support one or more YAML configuration files so users deployers provide this information without having to edit the Ruby source code. This would help reduce the risk of a user forgetting to update a value but also remove the risk of them accidently introducing a bug into the Ruby code.

Documentation should be provided as to what each of the e-mail addresses are used for. While, for example, exception_recipients is clear, the distinction between the e-mail addresses in contact_us.rb, devise.rb and user_mailer.rb is less clear.

---

## Using the DMPonline test service

Comments and questions arising from use of the DMPonline test service (https://dmponline-test.dcc.ac.uk/) and online resources.

### Usage

Rather than embedding HTML in JSON, parse the HTML into JSON e.g.:

    "answer_text":["blah","blah","table":[["header1"," header2"],["a","b"]]]

Add MarkDown as a plain-text Export option.

Is there an XML Schema defined for the XML export format? If so, publish it (e.g. add it to the Git repository). If not, define and publish it.

Provide an import function. This would allow users to work offline e.g. if they have no web access.

### Service provision

What is the difference between the servers:

* https://dmponline.dcc.ac.uk/
* https://dmponline-test.dcc.ac.uk/

I assume the later is for testing latest versions.

What happens if a user needs more space?

### Copyright and license

Code and content is marked "Copyright Digital Curation Centre (DCC)". Is the DCC a legal entity? Copyright owners need to be legal entitites.

### Documentation

[Guidelines on how to customise DMPonline for your institution](http://www.dcc.ac.uk/sites/default/files/documents/tools/dmpOnline/DMPonline-customisation-guidelines.pdf) are out of date now.

There isn't a 1-1 correspondance between:

* Question groups in [Checklist for a Data Management Plan](http://www.dcc.ac.uk/sites/default/files/documents/resource/DMP/DMP_Checklist_2013.pdf) (v.4.0, 2014).
* Appendix 1: Themes used in DMPonline in [Using the DMPonline admin interface: a guide to customising the tool](http://www.dcc.ac.uk/sites/default/files/documents/tools/dmpOnline/DMPonline-admin-interface-guide.pdf), 1.0, 20/06/14.

but there is between

* Appendix 2: Funder questions for DMPs (as of June 2014) in [Using the DMPonline admin interface: a guide to customising the tool](http://www.dcc.ac.uk/sites/default/files/documents/tools/dmpOnline/DMPonline-admin-interface-guide.pdf), 1.0, 20/06/14.
* [Summary of UK research funders' expectations for the content of data management and sharing plans](http://www.dcc.ac.uk/sites/default/files/documents/resource/policy/FundersDataPlanReqs_v4%204.pdf)

---

## Assessing impact

How is impact data collected for DMPonline? Is this from harvesting the number of organisations, users, plans from the DMPonline database?

What about impact data from third-party deployers e.g. University of Alberta DMP Builder and Consorcio Madrono PGDOnline?
