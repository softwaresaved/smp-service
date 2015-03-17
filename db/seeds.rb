# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

themes = [
]

themes.each do |details|
  theme = Theme.new
  theme.title = details[:title]
  theme.locale = details[:locale]
  theme.description = details[:description]
  theme.save!
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

guidance_groups = [
]

guidance_groups.each do |details|
  guidance_group = GuidanceGroup.new
  guidance_group.name = details[:name]
  guidance_group.organisation = Organisation.find_by_abbreviation(details[:organisation])
  guidance_group.optional_subset = details[:optional_subset]
  guidance_group.save!
end

guidances = [
]

guidances.each do |details|
  guidance = Guidance.new
  guidance.text = details[:text]
  guidance.guidance_groups << GuidanceGroup.find_by_name(details[:guidance_group])
  details[:themes].each do |theme|
    guidance.themes << Theme.find_by_title(theme)
  end
  guidance.save!
end

templates = [
  {
    title: "SSI Guide Template",
    description: "A bare-bones template based exactly on the SSI software management plans guide",
    published: true,
    organisation: "SSI",
    locale: "en",
    is_default: false
  },
  {
    title: "SSI Enhanced Template",
    description: "An enhanced SSI template complemented with guidance",
    published: true,
    organisation: "SSI",
    locale: "en",
    is_default: true
  },
]

templates.each do |details|
  template = Dmptemplate.new
  template.title = details[:title]
  template.description = details[:description]
  template.published = details[:published]
  template.locale = details[:locale]
  template.is_default = details[:is_default]
  template.organisation = Organisation.find_by_abbreviation(details[:organisation])
  template.save!
end

phases = [
  {
    title: "SSI Guide SMP",
    number: 1,
    template: "SSI Guide Template"
  },
  {
    title: "SSI Enhanced SMP",
    number: 1,
    template: "SSI Enhanced Template"
  },
]

phases.each do |details|
  phase = Phase.new
  phase.title = details[:title]
  phase.number = details[:number]
  phase.dmptemplate = Dmptemplate.find_by_title(details[:template])
  phase.save!
end

versions = [
  {
    title: "SSI Guide SMP Version 1",
    number: 1,
    phase: "SSI Guide SMP"
  },
  {
    title: "SSI Enhanced SMP Version 1",
    number: 1,
    phase: "SSI Enhanced SMP"
  },
]

versions.each do |details|
  version = Version.new
  version.title = details[:title]
  version.number = details[:number]
  version.phase = Phase.find_by_title(details[:phase])
  version.published = Phase.find_by_title(details[:phase]).dmptemplate.published
  version.save!
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
  "SSI Enhanced SMP Version 1" => [
    {
      title: "Software Assets Used and Produced",
      description: "TODO",
      organisation: "SSI"
    },
    {
      title: "Intellectual Property",
      description: "TODO",
      organisation: "SSI"
    },
    {
      title: "Governance",
      description: "TODO",
      organisation: "SSI"
    },
    {
      title:  "Access, Sharing and Reuse",
      description: "TODO",
      organisation: "SSI"
    },
    {
      title: "Long-term Preservation",
      description: "TODO",
      organisation: "SSI"
    },
    {
      title: "Resourcing and Responsibility",
      description: "TODO",
      organisation: "SSI"
    },
  ]
}

sections.each do |version, version_sections|
  number = 1
  version_sections.each do |details|
    section = Section.new
    section.title = details[:title]
    section.number = number
    number = number + 1
    section.description = details[:description]
    section.version = Version.find_by_title(version)
    section.organisation = Organisation.find_by_abbreviation(details[:organisation])
    section.save!
  end
end

questions = {
  "SSI Guide SMP Version 1" => [
    {
      text: "What software will be used by your project?",
      section: "Software Assets Used and Produced",
      number: 1,
      themes: [],
      format: "Text area"
    },
    {
      text: "What software will be produced by your project?",
      section: "Software Assets Used and Produced",
      number: 2,
      themes: [],
      format: "Text area"
    },
    {
      text: "What are the dependencies / licenses for third party code, models, tools and libraries used?",
      section: "Software Assets Used and Produced",
      number: 3,
      themes: [],
      format: "Text area"
    },
    {
      text: "What would be the process for keeping an up to date list of software assets and dependencies?",
      section: "Software Assets Used and Produced",
      number: 4,
      themes: [],
      format: "Text area"
    },
    {
      text: "Have you chosen an appropriate licence for software developed by your project?",
      section: "Intellectual Property and Governance",
      number: 1,
      themes: [],
      format: "Text area"
    },
    {
      text: "Is your license clearly stated and acceptable to all partners?",
      section: "Intellectual Property and Governance",
      number: 2,
      themes: [],
      format: "Text area"
    },
    {
      text: "Do you have a governance model for your project or product?",
      section: "Intellectual Property and Governance",
      number: 3,
      themes: [],
      format: "Text area"
    },
    {
      text: "What are the licenses for third party code, models, tools and libraries used?",
      section: "Intellectual Property and Governance",
      number: 4,
      themes: [],
      format: "Text area"
    },
    {
      text: "Are there are issues with the compatibility of licenses for third party code, tools or libraries?",
      section: "Intellectual Property and Governance",
      number: 5,
      themes: [],
      format: "Text area"
    },
    {
      text: "Are there any issues that you are aware of to do with patents, copyright and other IP restrictions?",
      section: "Intellectual Property and Governance",
      number: 6,
      themes: [],
      format: "Text area"
    },
    {
      text: "Have you identified suitable project infrastructure early, particularly a code repository (either in-house or public)?",
      section: "Access, sharing and reuse",
      number: 1,
      themes: [],
      format: "Text area"
    },
    {
      text: "Will your project repository be public or private? Do you have a requirement for private storage?",
      section: "Access, Sharing and Reuse",
      number: 2,
      themes: [],
      format: "Text area"
    },
    {
      text: "What is required to be shared between partners / more widely?",
      section: "Access, Sharing and Reuse",
      number: 3,
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will manage releases (how often, how delivered, how will you decide when to release)?",
      section: "Access, Sharing and Reuse",
      number: 4,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you ensure you deliver 'what's needed' (e.g. acceptance criteria)?",
      section: "Access, Sharing and Reuse",
      number: 5,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you ensure you deliver 'correct' code (e.g. tests, frameworks, checklists, quality control)?",
      section: "Access, Sharing and Reuse",
      number: 6,
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will deliver readable code that can be understood by others (e.g. documentation, coding standards, code reviews, pair programming)?",
      section: "Access, Sharing and Reuse",
      number: 7,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easier for new team members to run and develop the software?",
      section: "Access, Sharing and Reuse",
      number: 8,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easy to write and run new tests?",
      section: "Access, Sharing and Reuse",
      number: 9,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easy to reference and cite the software produced by your project?",
      section: "Access, Sharing and Reuse",
      number: 10,
      themes: [],
      format: "Text area"
    },
    {
      text: "Where will you deposit software for long-term preservation/archival?",
      section: "Long-term Preservation",
      number: 1,
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your institutional repository allow deposit of software?",
      section: "Long-term Preservation",
      number: 2,
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your chosen repository have a clear preservation policy?",
      section: "Long-term Preservation",
      number: 3,
      themes: [],
      format: "Text area"
    },
      {
      text: "Is your chosen repository part of a distributed preservation collection?",
      section: "Long-term Preservation",
      number: 4,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you tracking data formats used (related to your data management plan)?",
      section: "Long-term Preservation",
      number: 5,
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you record specific and implicit dependencies (e.g. browsers, operating systems, SDKs) required by your software?",
      section: "Long-term Preservation",
      number: 6,
      themes: [],
      format: "Text area"
    },
    {
      text: "Do you have a need to record and track versions of service interfaces and any use of open or proprietary standards that may change/become superceded by others?",
      section: "Long-term Preservation",
      number: 7,
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your software require access to any public web services / infrastructure / databases that may change or disappear?",
      section: "Long-term Preservation",
      number: 8,
      themes: [],
      format: "Text area"
    },
    {
      text: "What software development model will you aim to use?",
      section: "Resourcing and Responsibility",
      number: 1,
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will support your software (how much effort is available, what level of service will you offer, how will you interact)? Will this change over time?",
      section: "Resourcing and Responsibility",
      number: 2,
      themes: [],
      format: "Text area"
    },
    {
      text: "What effort is available to support the software (funded on your project, unfunded volunteers, temporary, students)?",
      section: "Resourcing and Responsibility",
      number: 3,
      themes: [],
      format: "Text area"
    },
    {
      text: "Whose responsibility is it for different roles (e.g. project manager, build manager, technical authority, change board, support requests)?",
      section: "Resourcing and Responsibility",
      number: 4,
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will track who does and has done what (e.g. TODOs, issues, bugs and queries)?",
      section: "Resourcing and Responsibility",
      number: 5,
      themes: [],
      format: "Text area"
    },
    {
      text: "How do you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave (e.g. documentation, pair programming, reviews)?",
      section: "Resourcing and Responsibility",
      number: 6,
      themes: [],
      format: "Text area"
    },
    {
      text: "How often will you review and revise the software management plan?",
      section: "Resourcing and Responsibility",
      number: 7,
      themes: [],
      format: "Text area"
    },
    {
      text: "How does your software management plan relate to any data management plan?",
      section: "Resourcing and Responsibility",
      number: 8,
      themes: [],
      format: "Text area"
    },
  ],
  "SSI Enhanced SMP Version 1" => [
    {
      text: "What software will be produced by your project?",
      section: "Software Assets Used and Produced",
      number: 1,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What software will be used by your project?",
      section: "Software Assets Used and Produced",
      number: 2,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What are the third party code, models, tools and libraries used? (if any)",
      section: "Software Assets Used and Produced",
      number: 3,
      guidance: "TODO - consider and list any suitable alternatives (cf RAPPORT guide)",
      themes: [],
      format: "Text area"
    },
    {
      text: "What would be the process for keeping an up-to-date list of software assets and dependencies?",
      section: "Software Assets Used and Produced",
      number: 4,
      guidance: "TODO - add note about ensuring these will be around",
      themes: [],
      format: "Text area"
    },
    {
      text: "Have you chosen an open source or proprietary licence for your project?",
      section: "Intellectual Property",
      number: 1,
      guidance: "TODO. If adopting dual licencing then you may select both",
      themes: [],
      format: "Check box",
      options: ["Open source", "Proprietary", "Dual licencing"]
    },
    {
      text: "If open source, then have you chosen an OSI-approved open source licence?",
      section: "Intellectual Property",
      number: 2,
      guidance: "TODO",
      themes: [],
      format: "Radio buttons",
      options: ["Yes", "No"]
    },
    {
      text: "What licences have you chosen?",
      section: "Intellectual Property",
      number: 3,
      guidance: "TODO Describe your chosen licence(s) here",
      themes: [],
      format: "Text area"
    },
    {
      text: "Is your licence(s) clearly stated?",
      section: "Intellectual Property",
      number: 4,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Is your licence acceptable to all partners?",
      section: "Intellectual Property",
      number: 5,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What are the licences for third party code, models, tools and libraries used?",
      section: "Intellectual Property",
      number: 6,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Are there are issues with the compatibility of licences for third party code, tools or libraries?",
      section: "Intellectual Property",
      number: 7,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Who is the copyright holder for any software you produce",
      section: "Intellectual Property",
      number: 8,
      guidance: "TODO - must be a legal entity",
      themes: [],
      format: "Text area"
    },
    {
      text: "Are there any issues that you are aware of to do with patents, copyright and other IP restrictions?",
      section: "Intellectual Property",
      number: 9,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Do you have a governance model for your project or product?",
      section: "Governance",
      number: 1,
      guidance: "TODO - add link to OSSWatch",
      themes: [],
      format: "Text area"
    },
    {
      text: "Have you identified suitable project infrastructure early, particularly a code repository (either in-house or public)?",
      section: "Access, sharing and reuse",
      number: 1,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Will your project repository be public or private? Do you have a requirement for private storage?",
      section: "Access, Sharing and Reuse",
      number: 2,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What is required to be shared between partners / more widely?",
      section: "Access, Sharing and Reuse",
      number: 3,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will manage releases (how often, how delivered, how will you decide when to release)?",
      section: "Access, Sharing and Reuse",
      number: 4,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you ensure you deliver 'what's needed' (e.g. acceptance criteria)?",
      section: "Access, Sharing and Reuse",
      number: 5,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you ensure you deliver 'correct' code (e.g. tests, frameworks, checklists, quality control)?",
      section: "Access, Sharing and Reuse",
      number: 6,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will deliver readable code that can be understood by others (e.g. documentation, coding standards, code reviews, pair programming)?",
      section: "Access, Sharing and Reuse",
      number: 7,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easier for new team members to run and develop the software?",
      section: "Access, Sharing and Reuse",
      number: 8,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easy to write and run new tests?",
      section: "Access, Sharing and Reuse",
      number: 9,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you make it easy to reference and cite the software produced by your project?",
      section: "Access, Sharing and Reuse",
      number: 10,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Where will you deposit software for long-term preservation/archival?",
      section: "Long-term Preservation",
      number: 1,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your institutional repository allow deposit of software?",
      section: "Long-term Preservation",
      number: 2,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your chosen repository have a clear preservation policy?",
      section: "Long-term Preservation",
      number: 3,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Is your chosen repository part of a distributed preservation collection?",
      section: "Long-term Preservation",
      number: 4,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you tracking data formats used (related to your data management plan)?",
      section: "Long-term Preservation",
      number: 5,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How will you record specific and implicit dependencies (e.g. browsers, operating systems, SDKs) required by your software?",
      section: "Long-term Preservation",
      number: 6,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Do you have a need to record and track versions of service interfaces and any use of open or proprietary standards that may change/become superceded by others?",
      section: "Long-term Preservation",
      number: 7,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Does your software require access to any public web services / infrastructure / databases that may change or disappear?",
      section: "Long-term Preservation",
      number: 8,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What software development model will you aim to use?",
      section: "Resourcing and Responsibility",
      number: 1,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will support your software (how much effort is available, what level of service will you offer, how will you interact)? Will this change over time?",
      section: "Resourcing and Responsibility",
      number: 2,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "What effort is available to support the software (funded on your project, unfunded volunteers, temporary, students)?",
      section: "Resourcing and Responsibility",
      number: 3,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "Whose responsibility is it for different roles (e.g. project manager, build manager, technical authority, change board, support requests)?",
      section: "Resourcing and Responsibility",
      number: 4,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How you will track who does and has done what (e.g. TODOs, issues, bugs and queries)?",
      section: "Resourcing and Responsibility",
      number: 5,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How do you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave (e.g. documentation, pair programming, reviews)?",
      section: "Resourcing and Responsibility",
      number: 6,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How often will you review and revise the software management plan?",
      section: "Resourcing and Responsibility",
      number: 7,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
    {
      text: "How does your software management plan relate to any data management plan?",
      section: "Resourcing and Responsibility",
      number: 8,
      guidance: "TODO",
      themes: [],
      format: "Text area"
    },
  ]
}

questions.each do |version_name, version_questions|
  version = Version.find_by_title(version_name)
  version_questions.each do |details|
    question = Question.new
    question.text = details[:text]
    question.number = details[:number]
    question.guidance = details[:guidance]
    question.question_format = QuestionFormat.find_by_title(details[:format])
    sections = Section.find_all_by_title(details[:section])
    section = sections.find {|h| h['version_id'] == version.id}
    question.section = section
    details[:themes].each do |theme|
      question.themes << Theme.find_by_title(theme)
    end
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

formatting = {
  'SSI' => {
    font_face: "Arial, Helvetica, Sans-Serif",
    font_size: 11,
    margin: { top: 20, bottom: 20, left: 20, right: 20 }
  },
}

formatting.each do |org, settings|
  organisation = Organisation.find_by_abbreviation(org)
  templates = Dmptemplate.find_all_by_organisation_id(organisation.id)
  templates.each do |template|
    template.settings(:export).formatting = settings
    template.save!
  end
end
