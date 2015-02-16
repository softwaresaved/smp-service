
# DMPonline deployment and usage experiences

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 13/02/2014.

## Introduction

Experiences in deploying and using DMPonline, between 19/01/14 and 13/02/14.

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
<pre>
$ irb
2.2.0 :001 > require 'securerandom'
 => true 
2.2.0 :002 > SecureRandom.hex(64)
 => "bfe98e994ee0416218f638f1fd2f4b8857e63fcd6f6bd3c2b6df25fd5b5362efe3ed90fd6624ddcda9cd90b98ebe42a0d44d0c0b4f41396d2ba56d9476602ee1" 
2.2.0 :003 > 
</pre>

Alternatively:
<pre>
$ rake secret
</pre>

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

It is unclear to new deployers how to get started using their deployment. A sample template and question set configured and ready for use would provide deployers with a head start.

In addition/or alternatively, how to use the admin or super-admin interfaces to populate a deployment which has no funders, organisations, templates or questions defined would also be useful.

### Problems

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
			<li>
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
<pre>
project: #&lt;Project:0x00000009ad6250&gt;
project.name: My plan (DCC Template)
project.plans: []
</pre>

MySQL listed no plans:
<pre>
> use dmpdev4;
> select * from plans;
Empty set (0.00 sec)
</pre>

I inserted an entry into plans:
<pre>
> insert into plans values(1,NULL,1,1,"2014-01-01 14:00","2014-01-01 14:00");
</pre>

Refreshing the page showed the DCC Template tab but it had no content.

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

The section appeared under Plan details and DCC Template.

* Select Templates Management => Question
* Click New Question
* Text: What is your SMP
* Number: 1
* Section: DCC Template - SSI
* Select question format: Text field
* Themes: None
* Click Create Question

The question appeared under DCC Template.

I tried to add existing sections:

* Select Templates Management => Sections
* Click Data Collection Edit
* Select Organisation: Digital Curation Centre
* Click Update Section

The section appeared under Plan details but viewing DCC Template gave an error:
<pre>
Extracted source (around line #17):

17:                 <% if q_format.title == t("helpers.checkbox") || q_format.title == t("helpers.multi_select_box") || q_format.title == t("helpers.radio_buttons") || q_format.title == t("helpers.dropdown") then%>
</pre>

So I looked at the questions associated with that section:

* Select Templates Management => Question
* Click What data will you collect or create? Edit
* Select question format: Text area - this was blank
* Click Update question
* Click How will the data be collected or created? Edit
* Select question format: Text area - this was blank
* Click Update question

DCC Template showed the questions.

At present, I don't know if:

* There is a problem with my Ruby or Rails versions.
* There is a bug in the DMPonline version in GitHub.
* I have not configured something I should.

It is unclear how projects relate to plans. For example, in the super-admin area clicking on Plans shows a list of projects.

### Code

What is DesktopDMPquestions_table.sql for? It creates a questions table whose schema differs from that of the one created by db:setup e.g.

* DesktopDMPquestions_table.sql defines a suggested_answer field.
* db:setup defines is_expanded, is_text_field, question_format_id fields.

### Back-ups

Document how users can back-up and restore their deployment e.g. Git can be used for DMPonline configuration files, and mysqldump for MySQL.

### Backwards compatibility

There should be a process for backwards compatibility and upgrades. For example, users should be warned if the database schema is going to be changed. Scripts should be provided to update their existing databases to conform to the new schema.

---

## Using the DMPonline test service

Comments and questions arising from use of the DMPonline test service (https://dmponline-test.dcc.ac.uk/) and online resources.

### Usage

Rather than embedding HTML in JSON, parse the HTML into JSON e.g.:

<pre>
"answer_text":["blah","blah","table":[["1","2"],["a","b"]]]
</pre>

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

How do you collect your impact data? Harvesting the number of organisations, users, plans from the DMPonline database?

What about impact data from third-party deployers e.g. University of Alberta DMP Builder and Consorcio Madrono PGDOnline?
