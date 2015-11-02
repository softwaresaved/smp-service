# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = [
  { 
    name: "admin"
  },
  { 
    name: "org_admin"
  },
]

roles.each do |details|
  role = Role.new
  role.name = details[:name]
  role.save!
end

organisation_types = [
  {
    name: "Organisation"
  },
  {
    name: "Funder"
  },
  {
    name: "Project"
  },
  {
    name: "School"
  },
  {
    name: "Institution"
  },
  {
    name: "Research Institute"
  },
]

organisation_types.each do |details|
  organisation_type = OrganisationType.new
  organisation_type.name = details[:name]
  organisation_type.save!
end

organisations = [
  {
    name: "The Software Sustainability Institute",
    abbreviation: "SSI",
    sort_name: "Software Sustainability Institute",
    organisation_type: "Institution"
  },
]

organisations.each do |details|
  organisation = Organisation.new
  organisation.name = details[:name]
  organisation.abbreviation = details[:abbreviation]
  organisation.domain = details[:domain]
  organisation.sort_name = details[:sort_name]
  organisation.organisation_type = OrganisationType.find_by_name(details[:organisation_type])
  organisation.save!
end

question_formats = [
  {
    title: "Text area"
  },
  {
    title: "Text field"
  },
  {
    title: "Radio buttons"
  },
  {
    title: "Check box"
  },
  {
    title: "Dropdown"
  },
  {
    title: "Multi select box"
  },
]

question_formats.each do |details|
  question_format = QuestionFormat.new
  question_format.title = details[:title]
  question_format.save!
end

templates = {
  "SSI" => [
    {
      title: "SSI Guide Template",
      description: "A bare-bones template based exactly on the SSI software management plans guide",
      published: true,
      locale: "en",
      is_default: false
    },
    {
      title: "SSI Extended Template",
      description: "An extended SSI template complemented with guidance and advice",
      published: true,
      locale: "en",
      is_default: false
    },
    {
      title: "Software Evaluation Service",
      description: "SSI's software evaluation service",
      published: true,
      locale: "en",
      is_default: true
    },
  ],
}

templates.each do |organisation_abbreviation, org_templates|
  organisation = Organisation.find_by_abbreviation(organisation_abbreviation)
  org_templates.each do |details|
    template = Dmptemplate.new
    template.title = details[:title]
    template.description = details[:description]
    template.published = details[:published]
    template.locale = details[:locale]
    template.is_default = details[:is_default]
    template.organisation = organisation
    template.save!
  end
end

phases = {
  "SSI Guide Template" => [
    {
      title: "SSI Guide SMP",
    }
  ],
  "SSI Extended Template" => [
    {
      title: "SSI Extended SMP",
    },
  ],
  "Software Evaluation Service" => [
    {
      title: "Software Evaluation Service",
    },
  ],
}

phases.each do |template_title, template_phases|
  template = Dmptemplate.find_by_title(template_title)
  phase_number = 1
  template_phases.each do |details|
    phase = Phase.new
    phase.title = details[:title]
    phase.number = phase_number
    phase_number += 1
    phase.dmptemplate = template
    phase.save!
  end
end

versions = {
  "SSI Guide SMP" => [
    {
      title: "SSI Guide SMP Version 1",
    },
  ],
  "SSI Extended SMP" => [
    {
      title: "SSI Extended SMP Version 1",
    },
  ],
  "Software Evaluation Service" => [
    {
      title: "Software Evaluation Service",
    },
  ],
}

versions.each do |phase_title, phase_versions|
  phase = Phase.find_by_title(phase_title)
  version_number = 1
  phase_versions.each do |details|
    version = Version.new
    version.title = details[:title]
    version.number = version_number
    version_number += 1
    version.phase = phase
    version.published = phase.dmptemplate.published
    version.save!
  end
end

sections = {
  "SSI Guide SMP Version 1" => [
    {
      title: "Software Assets Used and Produced",
      organisation: "SSI"
    },
    {
      title: "Intellectual Property and Governance",
      organisation: "SSI"
    },
    {
      title:  "Access, Sharing and Reuse",
      organisation: "SSI"
    },
    {
      title: "Long-term Preservation",
      organisation: "SSI"
    },
    {
      title: "Resourcing and Responsibility",
      organisation: "SSI"
    },
  ],
  "SSI Extended SMP Version 1" => [
    {
      title: "Software Assets to be Produced",
      description: "Software you will develop during your project",
      organisation: "SSI"
    },
    {
      title: "Software Assets to be Used",
      description: "Third-party software, scripts, models, libraries, tools you plan to use",
      organisation: "SSI"
    },
    {
      title: "Intellectual Property",
      description: "Intellectual property, copyright and licensing issues",
      organisation: "SSI"
    },
    {
      title: "Governance",
      description: "How the project will be managed",
      organisation: "SSI"
    },
    {
      title:  "Access, Sharing and Reuse",
      description: "Sharing code and other resources, both within the project, and more widely",
      organisation: "SSI"
    },
    {
      title:  "Maintainability",
      description: "Making your software easy to understand, fix and extend",
      organisation: "SSI"
    },
    {
      title:  "Testing",
      description: "Ensuring your software meets its requirements, is correct, and how correctness will be maintained",
      organisation: "SSI"
    },
    {
      title: "Impact",
      description: "Promoting uptake and use of your software",
      organisation: "SSI"
    },
    {
      title: "Long-term Preservation",
      description: "Preserving your software after your project has completed",
      organisation: "SSI"
    },
    {
      title: "Resourcing and Responsibility",
      description: "Implementing and resourcing the software management plan",
      organisation: "SSI"
    },
  ],
  "Software Evaluation Service" => [
    {
      title: "Section 1",
      description: "Section 1 is about section 1",
      organisation: "SSI"
    },
    {
      title: "Section 2",
      description: "Section 2 is about section 2",
      organisation: "SSI"
    },
  ],
}

sections.each do |version_title, version_sections|
  section_number = 1
  version = Version.find_by_title(version_title)
  version_sections.each do |details|
    section = Section.new
    section.title = details[:title]
    section.number = section_number
    section_number += 1
    section.description = details[:description]
    section.version = version
    section.organisation = Organisation.find_by_abbreviation(details[:organisation])
    section.save!
  end
end

questions = {
  "SSI Guide SMP Version 1" => {
    "Software Assets Used and Produced" => [
      {
        text: "What software will be used by your project?",
        format: "Text area"
      },
      {
        text: "What software will be produced by your project?",
        format: "Text area"
      },
      {
        text: "What are the dependencies / licenses for third party code, models, tools and libraries used?",
        format: "Text area"
      },
      {
        text: "What would be the process for keeping an up to date list of software assets and dependencies?",
        format: "Text area"
      },
    ],
    "Intellectual Property and Governance" => [
      {
        text: "Have you chosen an appropriate licence for software developed by your project?",
        format: "Text area"
      },
      {
        text: "Is your license clearly stated and acceptable to all partners?",
        format: "Text area"
      },
      {
        text: "Do you have a governance model for your project or product?",
        format: "Text area"
      },
      {
        text: "What are the licenses for third party code, models, tools and libraries used?",
        format: "Text area"
      },
      {
        text: "Are there are issues with the compatibility of licenses for third party code, tools or libraries?",
        format: "Text area"
      },
      {
        text: "Are there any issues that you are aware of to do with patents, copyright and other IP restrictions?",
        format: "Text area"
      },
    ],
    "Access, sharing and reuse" => [
      {
        text: "Have you identified suitable project infrastructure early, particularly a code repository (either in-house or public)?",
        format: "Text area"
      },
      {
        text: "Will your project repository be public or private? Do you have a requirement for private storage?",
        format: "Text area"
      },
      {
        text: "What is required to be shared between partners / more widely?",
        format: "Text area"
      },
      {
        text: "How you will manage releases (how often, how delivered, how will you decide when to release)?",
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'what's needed' (e.g. acceptance criteria)?",
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'correct' code (e.g. tests, frameworks, checklists, quality control)?",
        format: "Text area"
      },
      {
        text: "How you will deliver readable code that can be understood by others (e.g. documentation, coding standards, code reviews, pair programming)?",
        format: "Text area"
      },
      {
        text: "How will you make it easier for new team members to run and develop the software?",
        format: "Text area"
      },
      {
        text: "How will you make it easy to write and run new tests?",
        format: "Text area"
      },
      {
        text: "How will you make it easy to reference and cite the software produced by your project?",
        format: "Text area"
      },
    ],
    "Long-term Preservation" => [
      {
        text: "Where will you deposit software for long-term preservation/archival?",
        format: "Text area"
      },
      {
        text: "Does your institutional repository allow deposit of software?",
        format: "Text area"
      },
      {
        text: "Does your chosen repository have a clear preservation policy?",
        format: "Text area"
      },
      {
        text: "Is your chosen repository part of a distributed preservation collection?",
        format: "Text area"
      },
      {
        text: "How will you tracking data formats used (related to your data management plan)?",
        format: "Text area"
      },
      {
        text: "How will you record specific and implicit dependencies (e.g. browsers, operating systems, SDKs) required by your software?",
        format: "Text area"
      },
      {
        text: "Do you have a need to record and track versions of service interfaces and any use of open or proprietary standards that may change/become superceded by others?",
        format: "Text area"
      },
      {
        text: "Does your software require access to any public web services / infrastructure / databases that may change or disappear?",
        format: "Text area"
      },
    ],
    "Resourcing and Responsibility" => [
      {
        text: "What software development model will you aim to use?",
        format: "Text area"
      },
      {
        text: "How you will support your software (how much effort is available, what level of service will you offer, how will you interact)? Will this change over time?",
        format: "Text area"
      },
      {
        text: "What effort is available to support the software (funded on your project, unfunded volunteers, temporary, students)?",
        format: "Text area"
      },
      {
        text: "Whose responsibility is it for different roles (e.g. project manager, build manager, technical authority, change board, support requests)?",
        format: "Text area"
      },
      {
        text: "How you will track who does and has done what (e.g. TODOs, issues, bugs and queries)?",
        format: "Text area"
      },
      {
        text: "How do you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave (e.g. documentation, pair programming, reviews)?",
        format: "Text area"
      },
      {
        text: "How often will you review and revise the software management plan?",
        format: "Text area"
      },
      {
        text: "How does your software management plan relate to any data management plan?",
        format: "Text area"
      },
    ],
  },
  "SSI Extended SMP Version 1" => {
    "Software Assets to be Produced" => [
      {
        text: "What software will you produce?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>What is your software intended to do?</li><li>Who are the intended users?</li><li>How will it contribute to their research?</li><li>Why isn't existing software able to fulfil their requirements?</li></ul>",
        format: "Text area"
      },
    ],
    "Software Assets to be Used" => [
      {
        text: "What existing third-party software will you use? (if any)",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>What is the software needed for?</li><li>Is it free or do you have to pay?</li><li>If you have to pay, can you afford the payments for the lifetime of your project?</li><li>Will users need to pay for this software too?</li><li>If so, could this inhibit the uptake of your software?</li><li>Does the software look like it will be around, and supported, for as long as you need it?</li><li>Are there any alternatives that would also be suitable?</li></ul><p class='guidance_header'>Guidance:</p><p>Third-party software can also include scripts, models, libraries, tools.</p><p>See the Institute guide on <a href='http://www.software.ac.uk/choosing-right-open-source-software-your-project'>Choosing the right open source software for your project</a> - many of the points apply not just to choosing open source software, but any third-party software.</p>",
        format: "Text area"
      },
      {
        text: "What is the process for documenting and tracking software assets and dependencies?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will you document what software assets and dependencies you have?</li><li>Where will you record this information?</li><li>How frequently will it be updated?</li><li>How will you track the origins of dependencies, to be aware of whether there are bug fixes or optimisations made to these, so that your software can be upgraded?</li><li>Will you use any automated dependency management?</li></ul><p class='guidance_header'>Guidance:</p><p>Your software may need to combine:</p><ul><li>Original code, written by you.</li><li>Third-party source code, copied in and used as-is.</li><li>Modified, extended, or bug-fixed, third-party source code.</li><li>Third-party binaries (e.g. DLLs, JAR files etc) shipped by you</li><li>Third-party software that is downloaded and installed by users.</li></ul><p>Third-party software can include scripts, models, libraries, tools.</p><p>Summarising where this code originates from, what it is used for, its authors, copyright and licensing can help both project members and users understand who has contributed to the project (both explicitly and implicitly) and to ensure that the provenance and ownership of all its code is understood. This is especially important for open source projects. At a minimum the following should be recorded for third-party software:</p><ul><li>Name</li><li>Purpose</li><li>Location in repository, source code releases, and binary releases.</li><li>Origin, including web site.</li><li>Release, version, commit identifier, date or other identifying information.</li><li>Copyright and licence, with a link to a copyright and licence page.</li><li>Comments on any modifications made and why.</li></ul><p>There are tools available to help automate management of software dependencies e.g. <a href='http://maven.apache.org/'>Maven</a> or <a href='http://ant.apache.org/ivy/'>Ivy</a> for Java or <a href='http://rstudio.github.io/packrat/'>Packrat</a> for R.</li></ul></p>",
        format: "Text area"
      },
    ],
    "Intellectual Property" => [
      {
        text: "What type of software licence have you chosen?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>If using a proprietary licence, then have you considered dual licensing?</li></ul><p class='guidance_header'>Guidance:</p><p>As copyright holders, you can licence your software in as many ways as you want, though beware of any constraints imposed by the licences of third-party software you are using. <a href='http://oss-watch.ac.uk/resources/duallicence'>Dual licensing</a> is a model where where, for example, software can be freely released under GPL, requiring anyone who modifies it to release their modifications. For those wishing to make money from selling closed source modifications, a proprietary licence can be offered in which they are allowed to make closed source modifications but with yourselves being reimbursed in some way.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/adopting-open-source-licence'>Choosing an open source licence</a>.</p>",
        format: "Check box",
        options: ["Open source", "Proprietary"]
      },
      {
        text: "Have you chosen an OSI-approved open source licence?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>The <a href='http://opensource.org/'>Open Source Initiative</a> (OSI) have produced an <a href='http://opensource.org/osd'>Open Source Definition</a> which provides for a shared understanding of the term 'open source' and allows for OSI to accredit licences that meet this definition as 'OSI approved'. <a href='http://oss-watch.ac.uk'>OSS Watch</a> <a href='http://oss-watch.ac.uk/resources/opensourcesoftware'>comment</a> that this provides 'a means of avoiding debates over interpretation of the open source definition and which licences do or do not conform to it. By recognising the OSI as the appropriate final authority in this issue, much confusion is avoided.'</p><p>Some open source project hosting services will only host code licenced under an OSI-approved licence (e.g. see <a href='http://sourceforge.net'>SourceForge</a> <a href='http://slashdotmedia.com/terms-of-use/'>terms of use</a>).</p><p>See the list of <a href='http://opensource.org/licenses'>OSI-approved licences</a>.</p>",
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
      {
        text: "Is the licence valid under your national laws?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Certain licences may not be valid within certain countries e.g. the <a href='http://opensource.org/licenses/MIT'>MIT Public Licence </a> is <a href='http://www.software.ac.uk/blog/2013-07-31-should-we-be-scared-choosing-oss-licence#comment-5858'>not valid under UK law</a> as under UK law you cannot reject liability for personal injury or death. In this case, choosing an alternative free, open source, OSI-approved licence, e.g. <a href='http://www.gnu.org/copyleft/gpl.html'>GNU General Public License 3</a>, would provide similar licence conditions to the MIT Public License, but provides a limitation of liability which does not exclude applicable laws.</p>",
        format: "Radio buttons",
        options: ["Yes", "No", "Don't know"]
      },
      {
        text: "What licence have you chosen?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>For each licence, specify its name, a link to its licence text (if this is online), and a brief explanation as to why it has been chosen.</p><p>If there is no online link, summarise the key terms and conditions.</p>",
        format: "Text area"
      },
      {
        text: "Is your licence acceptable to all partners? If not, explain.",
        guidance: "<p class='guidance_header'>Guidance:</p><p>If one or more partners is unhappy with the licence then they may be reluctant to contribute to the development of the software, which could jeopardise the success of your project. Another choice of licence(s) may be more acceptable to all partners.</p>",
        format: "Text area"
      },
      {
        text: "Where will you publish your licence?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Linked from your download page?</li><li>Within your user documentation?</li><li>Within your source code repository?</li><li>Within any source code release?</li><li>Within every source file?</li><li>Within any binary release? (for GUIs, this could be via a Help menu option, for example)</li></ul><p class='guidance_header'>Guidance:</p><p>Licenses should be clearly stated so that users and developers can understand any conditions related to your software before they decide to use it.</p><p>Putting the licence text within each source code file means that, even if the source files become detached (if, for example, someone takes out a subset of code to use as a library elsewhere) the licence travels with them.</p>",
        format: "Text area"
      },
      {
        text: "What are the licences for third-party software you will use?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Do these put any obligations or constraints on you, your software or your users?</li><li>Might any of these cause problems for your project, or your users, now or in the future?</li></ul><p class='guidance_header'>Guidance:</p><p>Third-party software can include scripts, models, libraries, tools.</p><p>Third-party licences can put conditions on how you use software, whether you can redistribute it, under what conditions you can redistribute it, whether you can modify it, who owns the copyright of any modifications, and how the modifications must be licenced. For example, modifying code licensed under the <a href='http://www.gnu.org/copyleft/gpl.html'>GNU General Public License</a> requires the source code of the modifications to also be released under this license.</p>",
        format: "Text area"
      },
      {
        text: "Are there any compatibility issues with licences for third-party software that you are aware of? If so, explain.",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Third-party software can include scripts, models, libraries, tools.</p><p><a href='http://en.wikipedia.org/wiki/License_compatibility'>License compatibility</a> is 'an issue that arises when licenses applied to copyrighted works, particularly licenses of software packages, can contain contradictory requirements, rendering it impossible to combine source code or content from such works in order to create new ones.'</p><p>The <a href='http://ufal.github.io/lindat-license-selector/'>Lindat license selector</a> shows the compabibility of common open source licences.</p><p>GNU summarise <a href='http://www.gnu.org/licenses/license-list.html'>licences compatible with GNU GPL</a>.</p>",
        format: "Text area"
      },
      {
        text: "Who is the copyright holder for the software you will produce?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Any copyright holders must be legal entities e.g. people, companies, institutions.</p>",
        format: "Text area"
      },
      {
        text: "Are there any issues with patents, copyright and other IP restrictions that you are aware of? If so, explain.",
        guidance: "",
        format: "Text area"
      },
    ],
    "Governance" => [
      {
        text: "What is the governance model for your project?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will decisions be made as to when releases will be done and what features and bug fixes they will contain?</li><li>How will decisions be made as to when dependencies should be updated?</li><li>How will decisions be made as to when features will be deprecated?</li><li>How can users and non-project members contribute to the project (e.g. via bug fixes, features, tutorials, case-studies)? What is the process for managing these contributions? Who owns the copyright of these contributions?</li><li>How are users supported?</li><li>How will the project's developers communicate within themselves? Between themselves and users or third-party developers?</li></ul><p class='guidance_header'>Guidance:</p><p>A governance model sets out how a project is run. Specifically it sets out:</p><ul><li>The roles within the project and its community and the responsibilities associated with each role.</li><li>How the project supports its community.</li><li>What contributions can be made to the project, how they are made, any conditions the contributions must conform to, who retains copyright of the contributions and the process followed by the project in accepting the contribution.</li><li>The decision-making process in within the project.</li><p>Though they are designed for open source projects, many of their concerns are relevant to any software project.</p><p>For more information, see OSS Watch on <a href='http://oss-watch.ac.uk/resources/governancemodels'>governance models</a>.</p>",
        format: "Text area"
      },
    ],
    "Access, Sharing and Reuse" => [
      {
        text: "What project infrastructure (notably, code repository) will you use?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Does it provide the functions and features you need now?</li><li>Does it provide the functions and features you will need in the future?</li><li>Is it free or do you have to pay?</li><li>If you have to pay, can you afford the payments for the lifetime of your project?</li><li>Does it look like it will be around, and supported, for as long as you need it?</li><li>Are there any alternatives that would also be suitable?</li><li>Does it provide user management and access control?</li><li>Is it easy to backup, or export, all your content?</li><li>Is the quality of service (e.g. level of support, performance etc.) acceptable for your project?</li></ul><p class='guidance_header'>Guidance:</p><p>Infrastructure may be either in-house and/or public.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/choosing-repository-your-software-project'>Choosing a repository for your software project</a>.</p>",
        format: "Text area"
      },
      {
        text: "Will your project resources be public or private?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>What project resources, and information, can be made publicly-readable?</li><li>What needs to be kept private, and why?</li></li></ul><p class='guidance_header'>Guidance:</p><p>Project resources can include source code, user documentation, developer documentation, bugs and feature requests, work plans, budgets, roadmaps, data sets, e-mail archives etc.</p>",
        format: "Radio buttons",
        options: ["Public", "Private", "Both"]
      },
      { 
        text: "What project resources do you need to keep private?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Project resources can include source code, user documentation, developer documentation, bugs and feature requests, work plans, budgets, roadmaps, data sets, e-mail archives etc.</p>",
        format: "Text area"
      },
      {
        text: "What project resources need to be shared between project partners or more widely?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Project resources can include source code, user documentation, developer documentation, bugs and feature requests, work plans, budgets, roadmaps, data sets, e-mail archives etc.</p>",
        format: "Text area"
      },
      {
        text: "How you will manage releases?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Who decides what features and bug fixes a release will contain?</li><li>Who decides when releases will be done?</li><li>Who creates a release?</li><li>Who tests a release?</li><li>Who publishes a release?</li><li>Who archives a release?</li></ul><p class='guidance_header'>Guidance:</p><p>See the Institute guide on <a href='http://software.ac.uk/ready-release'>Ready for release?</a>.</p>",
        format: "Text area"
      },
    ],
    "Maintainability" => [
      {
        text: "How you will deliver readable code that can be understood by others?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Will you define coding standards?</li><li>Will you organise code reviews?</li><li>Will you encourage pair programming?</li></ul><p class='guidance_header'>Guidance:</p><p>Readable code is useful not only for the original developer if they need to modify or extend their code at a later date, but also for other developers who wish to modify or extend the code.</p><p>Coding standards can help ensure that source code is readable. Coding standards are valuable in collaborative projects as they recognise that the code belongs to the project as a whole, not any individual developer, and a common look-and-feel to the code helps foster collective ownership and the idea that any developer can work on any part of the code.</p><p>Code reviews, where one developer reviews another's code, can also promote readable code.</p><p>Pair programming, where two developers write code using one keyboard, can also help to ensure that the code is readable by more than one developer</p><p>See the Institute's guide on <a href='http://software.ac.uk/resources/guides/writing-readable-source-code'>Writing readable source code</a>.</p>",
        format: "Text area"
      },
      {
        text: "How will you help new team members to understand, run, develop and test the software?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Will you produce developer documentation?</li><li>Will you define coding standards?</li><li>Will you encourage pair programming?</li><li>Will you produce developer documentation?</li><li>Will you regularly review developer documentation to ensure it captures all the knowledge about the project?</li></ul><p class='guidance_header'>Guidance:</p><p>Readable code is useful not only for the original developer if they need to modify or extend their code at a later date, but also for new developers who need to understand, modify or extend the code.</p><p>Coding standards can help ensure that source code is readable. Coding standards are valuable in collaborative projects as they recognise that the code belongs to the project as a whole, not any individual developer, and a common look-and-feel to the code helps foster collective ownership and the idea that any developer can work on any part of the code.</p><p>Pair programming can encourage skills and knowledge transfer between existing and new team members.</p><p>Documenting everything about a project (e.g. what developers need to know, how to set up a development environment, how to create test data sets, how to run automated tests, how to undertake manual tests, how to do a release, how to use the project infrastructure, third-party dependencies, the process for updating these, data formats and APIs etc.) on a project resource (e.g. a wiki) ensures that information about the project is set down can also help to bring new members on board.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/developing-maintainable-software'>Developing maintainable software</a>.</p>",
        format: "Text area"
      },
    ],
    "Testing" => [
      {
        text: "How will you ensure you deliver 'what's needed'?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Do you have acceptance criteria?</li><li>Do you have representative users who can specify acceptance criteria, or otherwise, judge when the software is fit for purpose or producing scientifically-valid results?</li><li>Will you write automated tests?</li><li>Will you document manual tests? (e.g. for GUIs)</li></ul><p class='guidance_header'>Guidance:</p><p>Automated tests can help you to demonstrate that your software does what it claims to do, and that it does so correctly.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/testing-your-software'>Testing your software</a>.</p>",
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'correct' code?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Will you organise code reviews?</li><li>Will you write automated tests?</li><li>Will you adopt a continuous integration server?</li><li>Will you write regression tests?</li><li>Will you document manual tests? (e.g. for GUIs)</li></ul><p class='guidance_header'>Guidance:</p><p>Code reviews, where one developer reviews another's code are the most effective, and time-efficent, way to identify bugs.</p><p>Automated tests can help you to demonstrate that your software does what it claims to do, and that it does so correctly. They also help to ensure that changes made to software (e.g. bug fixes, optimisations, enhancements and new functionality) do not introduce new bugs.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/testing-your-software'>Testing your software</a>.</p><p>Continuous integration ensures that your software is built and tested regularly.</p><p>See the Institute guide on <a href='http://software.ac.uk/how-continuous-integration-can-help-you-regularly-test-and-release-your-software'>How continuous integration can help you regularly test and release your software</a>.</p>",
        format: "Text area"
      },
      {
        text: "How will you make it easy to write and run tests?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Will you design your software in a modular way that makes it easy for new tests?</li><li>Will you use a unit test framework?</li><li>Will you adopt a continuous integration server?</li></ul><p class='guidance_header'>Guidance:</p><p>Unit test frameworks provide support for writing, discovering, running and reporting the results of tests for software components e.g. functions or classes. Though they differ widely in their syntax and features, they typically support the following approach to automated testing:</p><ul><li>Set up the conditions under which a component will be tested.</li><li>Execute some feature of the component e.g. invokes some function of a class.</li><li>Check whether the component behaved as expected under the given conditions. For example, did a function return the expected output value for a valid input value, or did it throw the expected exception for an invalid input value.</li></ul><p><a href='http://en.wikipedia.org/wiki/XUnit'>xUnit test frameworks</p> typically support range of functions for checking whether a component behaved as expected e.g. testing integers for equality, checking floating-point values for equality to within a given tolerance, checking whether boolean conditions hold or not, or checking whether a specific exception was thrown.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/testing-your-software'>Testing your software</a>.</p><p>Continuous integration ensures that your software is built and tested regularly and can automatically trigger software builds and test runs when code is updated.</p><p>See the Institute guide on <a href='http://software.ac.uk/how-continuous-integration-can-help-you-regularly-test-and-release-your-software'>How continuous integration can help you regularly test and release your software</a>",
        format: "Text area"
      },
    ],
    "Impact" => [
      {
        text: "How will you make it easy to reference and cite the software produced by your project?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Do you recommend that users acknowledge the use of your software in their publications or software?</li><li>Do you recommend that users cite a reference if they your software in their publications or software?</li><li>Is the reference for a paper that describes your software?</li><li>Is the reference for your software itself?</li><li>Do you state the text they should use?</li><li>Are any of these conditions part of your software licence?</li></ul><p class='guidance_header'>Guidance:</p><p>Asking that users cite your software, directly or via its associated publications, provides you with credit for develop your software. It also provides a means, via harvesting of citations, of gathering evidence of the uptake and exploitation of your software.</p><p>See the Institute guide on <a href='http://software.ac.uk/so-exactly-what-software-did-you-use'>How to cite and describe software</a>. An Institute <a href='http://www.software.ac.uk/blog/2014-07-30-oh-research-software-how-shalt-i-cite-thee'>blog post</a> gives examples of the citations recommended by various softare packages.</p>",
        format: "Text area"
      },
    ],
    "Long-term Preservation" => [
      {
        text: "Where will you deposit software for long-term preservation/archival?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Is this an institution-specific or external repository?</li><li>Does it provide the functions and features you, and other interested parties, will need in the future?</li><li>Is it free or do you have to pay?</li><li>If you have to pay, can you afford the payments for envisaged preservation period?</li><li>Does it look like it will be around, and supported, for as long as you need it?</li><li>Is the quality of service (e.g. level of support, performance etc) acceptable for your project?</li><li>How much advance warning will you be given if the repository is discontinued?</li><li>Is it easy to backup, or export, all your content, if needed?</li><li>Are there any alternatives that would also be suitable?</li></ul><p class='guidance_header'>Guidance:</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/choosing-repository-your-software-project'>Choosing a repository for your software project</a>.</p>",
        format: "Text area"
      },
      {
        text: "What is the preservation policy of your chosen repository?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Does your chosen repository have a clear preservation policy?</li><li>How long will the repository be live for?</li></ul>",
        format: "Text area"
      },
      {
        text: "Is your chosen repository part of a distributed preservation collection?",
        guidance: "",
        format: "Text area"
      },
      {
        text: "What is the process for documenting and tracking data formats used?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will you document these dependencies?</li><li>Where will you record this information?</li><li>How frequently will it be updated?</li><li>How will you track these dependencies so that your software can be upgraded or modified accordingly?</li><li>What would be the impact on your software if any of these dependencies were to disappear or cease to be supported?</li><li>How will you design your code to minimise the coupling to these dependencies as far as possible?</li></ul><p class='guidance_header'>Guidance:</p><p>Summarising these dependencies, where they originate, and what they are used for can help both project members, and users, understand the additional dependencies that are needed to build, develop, test and use the software.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/defending-your-code-against-dependency-problems'>Defending your code against dependency problems</a>.</p><p>A data management plan helps you plan for the effective management of data you will use, to enable you to get the most out of your research.</p><p>See the Digital Curation Centre guide on <a href='http://www.dcc.ac.uk/resources/how-guides/develop-data-plan'>How to Develop a Data Management and Sharing Plan</a>.</p>",
        format: "Text area"
      },
      {
        text: "What is the process for documenting and tracking dependencies on browsers, operating systems, software development kits, languages etc?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will you document these dependencies?</li><li>Where will you record this information?</li><li>How frequently will it be updated?</li><li>How will you track these dependencies so that your software can be upgraded or modified accordingly?</li><li>What would be the impact on your software if any of these dependencies were to disappear or cease to be supported?</li><li>How will you design your code to minimise the coupling to these dependencies as far as possible?</li></ul><p class='guidance_header'>Guidance:</p><p>Summarising these dependencies, where they originate, and what they are used for can help both project members, and users, understand the additional dependencies that are needed to build, develop, test and use the software.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/defending-your-code-against-dependency-problems'>Defending your code against dependency problems</a>.</p>",
        format: "Text area"
      },
      {
        text: "What is the process for documenting and tracking dependencies on service interfaces, open or proprietary specifications and standards? (if any)",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will you document these dependencies?</li><li>Where will you record this information?</li><li>How frequently will it be updated?</li><li>How will you track these dependencies so that your software can be upgraded or modified accordingly?</li><li>What would be the impact on your software if any of these dependencies were to disappear or cease to be supported?</li><li>How will you design your code to minimise the coupling to these dependencies as far as possible?</li></ul><p class='guidance_header'>Guidance:</p><p>Summarising these dependencies, where they originate, and what they are used for can help both project members, and users, understand the additional dependencies that are needed to build, develop, test and use the software.</p><p>These should be explicitly documented, not just buried within the code itself.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/defending-your-code-against-dependency-problems'>Defending your code against dependency problems</a>.</p>",
        format: "Text area"
      },
      {
        text: "What is the process for documenting and tracking dependencies on public web services, infrastructure, or databases?",
        guidance: "<ul><li>How will you document these dependencies?</li><li>Where will you record this information?</li><li>How frequently will it be updated?</li><li>How will you track these dependencies so that your software can be upgraded or modified accordingly?</li><li>What would be the impact on your software if any of these dependencies were to disappear or cease to be supported?</li><li>How will you design your code to minimise the coupling to these dependencies as far as possible?</li></ul><p class='guidance_header'>Guidance:</p><p>Summarising these dependencies, where they originate, and what they are used for can help both project members, and users, understand the additional dependencies that are needed to build, develop, test and use the software.</p><p>These should be explicitly documented, not just buried within the code itself.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/defending-your-code-against-dependency-problems'>Defending your code against dependency problems</a>.</p>",
        format: "Text area"
      },
    ],
    "Resourcing and Responsibility" => [
      {
        text: "What software development model do you plan to use?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Wikipedia provides a summary of software development models, or processes under <a href='http://en.wikipedia.org/wiki/Software_development_process'>Software development process</a>.</p>",
        format: "Text area"
      },
      {
        text: "How you will support your software?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How much effort is available?</li><li>How will users and developers make support requests?</li><li>How will you manage support requests?</li><li>What level of service will you offer?</li></ul><p class='guidance_header'>Guidance:</p><p>Support requests should go to a resource to which more than one team member has access.</p><p>All requests should receive a response. This ensures the user does not feel ignored. An ignored support request may lead to a disgruntled user who may bad-mouth your software ('it does not work') or your project.</p><p>Responding to a user request does not imply fixing a bug or implementing a feature, it merely acknowledges that you've heard them. No-one has a right to expect support (for freely-provided software).</p><p>It can be helpful to indicate a level of service e.g. 'we aim to reply to all e-mails within 1 week'.</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/supporting-open-source-software'>Supporting open source software</a> - many of the points apply not just to supporting open source software, but any software.</p>",
        format: "Text area"
      },
      {
        text: "What effort is available to support and develop the software?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>What funded effort do you have?</li><li>Are there any temporary sources of effort? e.g. summer jobs for students</li><li>Will you allow unfunded volunteers to engage with, and contribute to, your project?</li><li>Have you considered using students as a source of development and support effort?</li></ul><p class='guidance_header'>Guidance:</p><p>See the Institute guide on <a href='http://software.ac.uk/resources/guides/recruiting-student-developers'>Recruiting student developers</a>, <a href='http://www.software.ac.uk/resources/guides/starting-community-taking-your-software-world'>Starting a community - taking your software to the world</a> and <a href='http://www.software.ac.uk/resources/guides/building-better-community'>Building a better community</a></p>",
        format: "Text area"
      },
      {
        text: "Whose responsibility is it for different project roles?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>Project roles can include: project manager, build manager, tester, release manager, technical authority (or architect), change board, support manager.</p>",
        format: "Text area"
      },
      {
        text: "How you will track who does and has done what?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>How will this information be recorded?</li><li>How will it be updated? By the project manager? By the individuals themselves?</li><li>Who will have access to this information?</li><li>What information do you need for progress monitoring and reporting?</li></ul>
<p class='guidance_header'>Guidance:</p><p>Project tasks can include: issues, bugs, optimisations, enhancements, new features, releases, documentation, presentations, queries, meetings with stakeholders etc.</p>",
        format: "Text area"
      },
      {
        text: "How will you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave?",
        guidance: "<p class='guidance_header'>Guidance:</p><p>A project's <a href='http://en.wikipedia.org/wiki/Bus_factor'>bus factor</a> is the number of developers that need to be taken out of action before noone left on the project understands some part of software.</p><p>Readable code and coding standards can help deliver code that is understandable by all developers on a project, not just the developer that wrote it.</p><p>Pair programming can encourage skills and knowledge transfer between developers and can help ensure that every component has at least two developers who are familiar with it.</p><p>Documenting everything about a project (e.g. what developers need to know, how to set up a development environment, how to create test data sets, how to run automated tests, how to undertake manual tests, how to do a release, how to use the project infrastructure, third-party dependencies, the process for updating these, data formats and APIs etc.) on a project resource (e.g. a wiki) ensures that information about the project is set down, and does not live in any individual's head.</p>",
        format: "Text area"
      },
      {
        text: "How often will you review and revise the software management plan?",
        guidance: "
<p class='guidance_header'>Guidance:</p><p>A software management plan is not set in stone but can be reviewed and adjusted as a project progresses. Outstanding questions at the outset of a project may now be answered. Some processes may not have worked well and have been replaced. Updating the software management plan allows you to reflect on how your project is progressing and to take corrective action.</p>",
        format: "Text area"
      },
      {
        text: "How does your software management plan relate to any data management plan?",
        guidance: "<p class='guidance_header'>Questions to consider:</p><ul><li>Does your software produce data that you will then use as a basis for publications?</li><li>Does your software produce data that you want to share with others as a research object in its own right?</li></ul><p class='guidance_header'>Guidance:</p><p>A data management plan helps you plan for the effective creation, management and sharing of your data, to enable you to get the most out of your research.</p><p>See the Digital Curation Centre guide on <a href='http://www.dcc.ac.uk/resources/how-guides/develop-data-plan'>How to Develop a Data Management and Sharing Plan</a>.</p>",
        format: "Text area"
      },
    ],
  },
  "Software Evaluation Service" => {
    "Section 1" => [
      {
        text: "Question 1.1...?",
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
      {
        text: "Question 1.2...?",
        format: "Radio buttons",
        options: ["Yes", "No", "Not applicable"]
      },
      {
        text: "Question 1.3...?",
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
    ],
    "Section 2" => [
      {
        text: "Question 2.1...?",
        format: "Radio buttons",
        options: ["Yes", "No", "Not applicable"]
      },
      {
        text: "Question 2.2...?",
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
      {
        text: "Question 2.3...?",
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
    ],
  },
}
                       

questions.each do |version_title, version_sections|
  version = Version.find_by_title(version_title)
  version_sections.each do |section_title, section_questions|
    sections = Section.find_all_by_title(section_title)
    section = sections.find {|h| h['version_id'] == version.id}
    question_number = 1
    section_questions.each do |details|
      question = Question.new
      question.text = details[:text]
      question.number = question_number
      question_number += 1
      question.guidance = details[:guidance]
      question.question_format = QuestionFormat.find_by_title(details[:format])
      question.section = section
      if (details[:format].eql? 'Radio buttons') or (details[:format].eql? 'Check box')
        i = 1
        details[:options].each do |opt|
          option = Option.new
          option.text = opt
          option.number = i
          i += 1
          option.save!
          question.options << option
        end
        question.options[0].is_default = true
        question.multiple_choice = true
      end
      question.save!
    end
  end
end

formatting = {
  'SSI' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
}

formatting.each do |organisation_abbreviation, settings|
  organisation = Organisation.find_by_abbreviation(organisation_abbreviation)
  templates = Dmptemplate.find_all_by_organisation_id(organisation.id)
  templates.each do |template|
    template.settings(:export).formatting = settings
    template.save!
  end
end
