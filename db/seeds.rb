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
      title: "SSI Enhanced Template",
      description: "An enhanced SSI template complemented with guidance and advice",
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
  "SSI Enhanced Template" => [
    {
      title: "SSI Enhanced SMP",
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
  "SSI Enhanced SMP" => [
    {
      title: "SSI Enhanced SMP Version 1",
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
        themes: [],
        format: "Text area"
      },
      {
        text: "What software will be produced by your project?",
        themes: [],
        format: "Text area"
      },
      {
        text: "What are the dependencies / licenses for third party code, models, tools and libraries used?",
        themes: [],
        format: "Text area"
      },
      {
        text: "What would be the process for keeping an up to date list of software assets and dependencies?",
        themes: [],
        format: "Text area"
      },
    ],
    "Intellectual Property and Governance" => [
      {
        text: "Have you chosen an appropriate licence for software developed by your project?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Is your license clearly stated and acceptable to all partners?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Do you have a governance model for your project or product?",
        themes: [],
        format: "Text area"
      },
      {
        text: "What are the licenses for third party code, models, tools and libraries used?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Are there are issues with the compatibility of licenses for third party code, tools or libraries?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Are there any issues that you are aware of to do with patents, copyright and other IP restrictions?",
        themes: [],
        format: "Text area"
      },
    ],
    "Access, sharing and reuse" => [
      {
        text: "Have you identified suitable project infrastructure early, particularly a code repository (either in-house or public)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Will your project repository be public or private? Do you have a requirement for private storage?",
        themes: [],
        format: "Text area"
      },
      {
        text: "What is required to be shared between partners / more widely?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will manage releases (how often, how delivered, how will you decide when to release)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'what's needed' (e.g. acceptance criteria)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'correct' code (e.g. tests, frameworks, checklists, quality control)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will deliver readable code that can be understood by others (e.g. documentation, coding standards, code reviews, pair programming)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easier for new team members to run and develop the software?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easy to write and run new tests?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easy to reference and cite the software produced by your project?",
        themes: [],
        format: "Text area"
      },
    ],
    "Long-term Preservation" => [
      {
        text: "Where will you deposit software for long-term preservation/archival?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your institutional repository allow deposit of software?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your chosen repository have a clear preservation policy?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Is your chosen repository part of a distributed preservation collection?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you tracking data formats used (related to your data management plan)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you record specific and implicit dependencies (e.g. browsers, operating systems, SDKs) required by your software?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Do you have a need to record and track versions of service interfaces and any use of open or proprietary standards that may change/become superceded by others?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your software require access to any public web services / infrastructure / databases that may change or disappear?",
        themes: [],
        format: "Text area"
      },
    ],
    "Resourcing and Responsibility" => [
      {
        text: "What software development model will you aim to use?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will support your software (how much effort is available, what level of service will you offer, how will you interact)? Will this change over time?",
        themes: [],
        format: "Text area"
      },
      {
        text: "What effort is available to support the software (funded on your project, unfunded volunteers, temporary, students)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "Whose responsibility is it for different roles (e.g. project manager, build manager, technical authority, change board, support requests)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will track who does and has done what (e.g. TODOs, issues, bugs and queries)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How do you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave (e.g. documentation, pair programming, reviews)?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How often will you review and revise the software management plan?",
        themes: [],
        format: "Text area"
      },
      {
        text: "How does your software management plan relate to any data management plan?",
        themes: [],
        format: "Text area"
      },
    ],
  },
  "SSI Enhanced SMP Version 1" => {
    "Software Assets Used and Produced" => [
      {
        text: "What software will be produced by your project?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "What software will be used by your project?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "What are the third party code, models, tools and libraries used? (if any)",
        guidance: "TODO - consider and list any suitable alternatives (cf RAPPORT guide)",
        themes: [],
        format: "Text area"
      },
      {
        text: "What would be the process for keeping an up-to-date list of software assets and dependencies?",
        guidance: "TODO - add note about ensuring these will be around",
        themes: [],
        format: "Text area"
      },
    ],
    "Intellectual Property" => [
      {
        text: "Have you chosen an open source or proprietary licence for your project?",
        guidance: "TODO. If adopting dual licencing then you may select both",
        themes: [],
        format: "Check box",
        options: ["Open source", "Proprietary", "Dual licencing"]
      },
      {
        text: "If open source, then have you chosen an OSI-approved open source licence?",
        guidance: "TODO",
        themes: [],
        format: "Radio buttons",
        options: ["Yes", "No"]
      },
      {
        text: "What licences have you chosen?",
        guidance: "TODO Describe your chosen licence(s) here",
        themes: [],
        format: "Text area"
      },
      {
        text: "Is your licence(s) clearly stated?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Is your licence acceptable to all partners?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "What are the licences for third party code, models, tools and libraries used?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Are there are issues with the compatibility of licences for third party code, tools or libraries?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Who is the copyright holder for any software you produce",
        guidance: "TODO - must be a legal entity",
        themes: [],
        format: "Text area"
      },
      {
        text: "Are there any issues that you are aware of to do with patents, copyright and other IP restrictions?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
    ],
    "Governance" => [
      {
        text: "Do you have a governance model for your project or product?",
        guidance: "TODO - add link to OSSWatch",
        themes: [],
        format: "Text area"
      },
    ],
    "Access, sharing and reuse" => [
      {
        text: "Have you identified suitable project infrastructure early, particularly a code repository (either in-house or public)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Will your project repository be public or private? Do you have a requirement for private storage?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "What is required to be shared between partners / more widely?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will manage releases (how often, how delivered, how will you decide when to release)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'what's needed' (e.g. acceptance criteria)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you ensure you deliver 'correct' code (e.g. tests, frameworks, checklists, quality control)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will deliver readable code that can be understood by others (e.g. documentation, coding standards, code reviews, pair programming)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easier for new team members to run and develop the software?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easy to write and run new tests?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you make it easy to reference and cite the software produced by your project?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
    ],
    "Long-term Preservation" => [
      {
        text: "Where will you deposit software for long-term preservation/archival?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your institutional repository allow deposit of software?",

        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your chosen repository have a clear preservation policy?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Is your chosen repository part of a distributed preservation collection?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you tracking data formats used (related to your data management plan)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How will you record specific and implicit dependencies (e.g. browsers, operating systems, SDKs) required by your software?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Do you have a need to record and track versions of service interfaces and any use of open or proprietary standards that may change/become superceded by others?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Does your software require access to any public web services / infrastructure / databases that may change or disappear?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
    ],
    "Resourcing and Responsibility" => [
      {
        text: "What software development model will you aim to use?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will support your software (how much effort is available, what level of service will you offer, how will you interact)? Will this change over time?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "What effort is available to support the software (funded on your project, unfunded volunteers, temporary, students)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "Whose responsibility is it for different roles (e.g. project manager, build manager, technical authority, change board, support requests)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How you will track who does and has done what (e.g. TODOs, issues, bugs and queries)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How do you ensure adequate knowledge exchange within the team to ensure that knowledge is not lost when people leave (e.g. documentation, pair programming, reviews)?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How often will you review and revise the software management plan?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
      {
        text: "How does your software management plan relate to any data management plan?",
        guidance: "TODO",
        themes: [],
        format: "Text area"
      },
    ],
  }
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
