# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dmptemplate default formatting settings based on https://je-s.rcuk.ac.uk/Handbook/pages/GuidanceonCompletingaStandardG/CaseforSupportandAttachments/CaseforSupportandAttachments.htm

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
  }
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
  {
    name: "Digital Curation Centre",
    abbreviation: "DCC",
    sort_name: "Digital Curation Centre",
    organisation_type: "Organisation"
  }
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
  {
    title: "Related Policies",
    locale: "en"
  },
  {
    title: "Responsibilities",
    locale: "en"
  },
  {
    title: "Discovery by Users",
    locale: "en"
  },
  {
    title: "Preservation Plan",
    locale: "en"
  },
  {
    title: "Period of Preservation",
    locale: "en"
  },
  {
    title: "Data Security",
    locale: "en"
  },
  {
    title: "Method For Data Sharing",
    locale: "en"
  },
  {
    title: "Data Capture Methods",
    locale: "en"
  },
  {
    title: "Existing Data",
    locale: "en"
  },
  {
    title: "Restrictions on Sharing",
    locale: "en"
  },
  {
    title: "Data Repository",
    locale: "en"
  },
  {
    title: "Timeframe For Data Sharing",
    locale: "en"
  },
  {
    title: "Expected Reuse",
    locale: "en"
  },
  {
    title: "Data Description",
    locale: "en"
  },
  {
    title: "Resourcing",
    locale: "en"
  },
  {
    title: "Data Quality",
    locale: "en"
  },
  {
    title: "Data Selection",
    locale: "en"
  },
  {
    title: "Relationship to Existing Data",
    locale: "en"
  },
  {
    title: "Data Volumes",
    locale: "en"
  },
  {
    title: "IPR Ownership and Licencing",
    locale: "en"
  },
  {
    title: "Managed Access Procedures",
    locale: "en"
  },
  {
    title: "Ethical Issues",
    locale: "en"
  },
  {
    title: "Metadata",
    locale: "en"
  },
  {
    title: "Documentation",
    locale: "en"
  },
  {
    title: "Storage and Backup",
    locale: "en"
  },
  {
    title: "Data Type",
    locale: "en"
  },
  {
    title: "Data Format",
    locale: "en"
  },
  {
    title: "ID",
    locale: "en",
    description: "An ID or reference number relevant to this DMP."
  },
  {
    title: "Project Name",
    locale: "en",
    description: "The Project Name given here should be the same as on any other documentation, for example, grant applications, ethics approval forms, etc."
  },
  {
    title: "Project Description",
    locale: "en",
    description: "A brief description of the project"
  },
  {
    title: "PI / Researcher",
    locale: "en",
    description: "The name of the PI or Researcher who is responsible for this research project"
  }
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
  {
    name: "DCC Guidance",
    organisation: "DCC",
    optional_subset: false
  },
]

guidance_groups.each do |details|
  guidance_group = GuidanceGroup.new
  guidance_group.name = details[:name]
  guidance_group.organisation = Organisation.find_by_abbreviation(details[:organisation])
  guidance_group.optional_subset = details[:optional_subset]
  guidance_group.save!
end

guidances = [
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are any restrictions on data sharing required? e.g. limits on who can use the data, when and for what purpose.</li> <li>What restrictions are needed and why?</li> <li>What action will you take to overcome or minimise restrictions?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline any expected difficulties in data sharing, along with causes and possible measures to overcome these. Restrictions to data sharing may be due to participant confidentiality, consent agreements or IPR. Strategies to limit restrictions may include: anonymising or aggregating data; gaining participant consent for data sharing; gaining copyright permissions; and agreeing a limited embargo period. </p>",
    guidance_group: "DCC Guidance",
    themes: ["Restrictions on Sharing"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are there any existing data or methods that you can reuse?</li><li>Do you need to pay to reuse existing data?</li><li>Are there any restrictions on the reuse of third-party data?</li><li>Can the data that you create - which may be derived from third-party data - be shared?</li> </ul> <p class='guidance_header'>Guidance: </p> <p>Check to see if there are any existing data that you can reuse, for examples by consulting relevant repositories. When creating new data sources, explain why existing data sources cannot be reused. If purchasing or reusing existing data sources, explain how issues such as copyright and IPR have been addressed. A list of repositories is provided by <a target='_blank' href='http://databib.org'>Databib</a> or <a target='_blank' href='http://www.re3data.org'>Re3data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Existing Data"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Are there any existing procedures that you will base your approach on?</li> <li>Does your department/group have data management guidelines?</li> <li>Does your institution have a data protection or security policy that you will follow?</li> <li>Does your institution have a Research Data Management (RDM) policy?</li> <li>Does your funder have a Research Data Management policy?</li> <li>Are there any formal standards that you will adopt?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>List any other relevant funder, institutional, departmental or group policies on data management, data sharing and data security. Some of the information you give in the remainder of the DMP will be determined by the content of other policies. If so, point/link to them here.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Related Policies"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Do you have sufficient storage?</li> <li>Do you need to include costs for additional managed storage?</li> <li>Will the scale of the data pose challenges when sharing or transferring data between sites?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider the implications of data volumes in terms of storage, backup and access. Estimate the volume of data in MB/GB/TB and how this will grow to make sure any additional storage and technical support required can be provided.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Volumes"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Have you gained consent for data preservation and sharing?</li> <li>How will sensitive data be handled to ensure it is stored and transferred securely?</li> <li>How will you protect the identity of participants? e.g. via anonymisation or using managed access procedures</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Investigators carrying out research involving human participants must ensure that consent is obtained to share data. Managing ethical concerns may include: anonymisation of data; referral to departmental or institutional ethics committees; and formal consent agreements. Ethical issues may affect how you store data, who can see/use it and how long it is kept. You should show that you&#8217;re aware of this and have planned accordingly.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/legal-ethical/consent-data-sharing.aspx'>consent for data sharing</a></p>",
    guidance_group: "DCC Guidance",
    themes: ["Ethical Issues"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How long will the data be retained and preserved?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>This may depend on the type of data. Most research funders expect data to be retained for a minimum of 10 years from the end of the project. For data that by their nature cannot be re-measured, efforts should be made to retain them indefinitely.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Period of Preservation"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will potential users find out about your data?</li> <li>Will you provide metadata online to aid discovery and reuse?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate how potential new users can find out about your data and identify whether they could be suitable for their research purposes. For example, you may provide basic discovery metadata online (i.e. the title, author, subjects, keywords and publisher).</p>",
    guidance_group: "DCC Guidance",
    themes: ["Discovery by Users"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will the data be created?</li> <li>What standards or methodologies will you use?</li><li>How will you structure and name your folders and files?</li><li>How will you ensure that different versions of a dataset are easily identifiable?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline how the data will be collected/generated and which community data standards (if any) will be used at this stage. Indicate how the data will be organised during the project, mentioning for example naming conventions, version control and folder structures. Consistent, well-ordered research data will be easier for the research team to find, understand and reuse.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Capture Methods"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will you control data capture to ensure data quality?</li> <li>What quality assurance processes will you adopt?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Explain how the consistency and quality of data collection will be controlled and documented. This may include processes such as calibration, repeat samples or measurements, standardised data capture or recording, data entry validation, peer review of data or representation with controlled vocabularies.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Quality"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>How will you make the data available to others?</li> <li>With whom will you share the data, and under what conditions?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider where, how, and to whom the data should be made available. Will you share data via a data repository, handle data requests directly or use another mechanism? </p> <p>The methods used to share data will be dependent on a number of factors such as the type, size, complexity and sensitivity of data. Mention earlier examples to show a track record of effective data sharing.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Method For Data Sharing"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What are the risks to data security and how will these be managed?</li> <li>Will you follow any formal standards?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>If your data is sensitive (e.g. detailed personal data, politically sensitive information or trade secrets) you should discuss any appropriate security measures that you will be taking. Note the main risks and how these will be managed. Identify any formal standards that you will comply with e.g. ISO 27001.</p> <p>See DCC Briefing Paper on <a target='_blank' href='http://www.dcc.ac.uk/resources/briefing-papers/standards-watch-papers/information-security-management-iso-27000-iso-27k-s'>Information Security Management - ISO 27000</a>.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/store/security.aspx'>data security</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Security"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What data will you create?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Give a brief description of the data that will be created, noting its content and coverage</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Description"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What format will your data be in?</li> <li>Why have you chosen to use particular formats?</li> <li>Do the chosen formats and software enable sharing and long-term validity of data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline and justify your choice of format e.g. SPSS, Open Document Format, tab-delimited format, MS Excel. Decisions may be based on staff expertise, a preference for open formats, the standards accepted by data centres or widespread usage within a given community. Using standardised and interchangeable or open lossless data formats ensures the long-term usability of data.</p> <p>See UKDS Guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/format/recommended-formats.aspx'>recommended formats</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Format"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What is the long-term preservation plan for the dataset? e.g. deposit in a data repository</li> <li>Will additional resources be needed to prepare data for deposit or meet charges from data repositories?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Researchers should consider how datasets that have long-term value will be preserved and curated beyond the lifetime of the grant. Also outline the plans for preparing and documenting data for sharing and archiving.</p> <p>If you do not propose to use an established repository, the data management plan should demonstrate that resources and systems will be in place to enable the data to be curated effectively beyond the lifetime of the grant.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Preservation Plan"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What is the relationship to existing data e.g. in public repositories?</li> <li>How does your data complement and integrate with existing data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Consider the relationship between the data that you will capture and existing data available in public repositories or elsewhere.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Relationship to Existing Data"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What metadata, documentation or other supporting material should accompany the data for it to be interpreted correctly?</li> <li>What information needs to be retained to enable the data to be read and interpreted in the future?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Describe the types of documentation that will accompany the data to provide secondary users with any necessary details to prevent misuse, misinterpretation or confusion. This may include information on the methodology used to collect the data, analytical and procedural information, definitions of variables, units of measurement, any assumptions made, the format and file type of the data.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Documentation"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>What types of data will you create?</li> <li>Which types of data will have long-term value?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline the types of data that are expected to be produced from the project e.g. quantitative, qualitative, survey data, experimental measurements, models, images, audiovisual data, samples etc. Include the raw data arising directly from the research, the reduced data derived from it, and published data.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Type"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>When will you make the data available?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Data (with accompanying metadata) should be shared in a timely fashion. It is generally expected that timely release would be no later than publication of the main findings and should be in-line with established best practice in the field. Researchers have a legitimate interest in benefiting from their investment of time and effort in producing data, but not in prolonged exclusive use.  Research funders typically allow embargoes in line with practice in the field, but expect these to be outlined up-front and justified.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Timeframe For Data Sharing"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Where (i.e. in which repository) will the data be deposited?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Most research funders recommend the use of established data repositories, community databases and related initiatives to aid data preservation, sharing and reuse.</p> <p>An international list of data repositories is available via <a target='_blank' href='http://databib.org'>Databib</a> or <a target='_blank' href='http://www.re3data.org'>Re3data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Repository"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Which data are of long-term value and should be shared and/or preserved?</li> <li>How will you decide what to keep?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate which data you intend to preserve beyond the period of funding. This should be based on what has long-term value and is economically viable to keep. Consider how long you wish to keep the data and what will happen to it e.g. deposit in a data repository to enable reuse.</p> <p>See the DCC guide: <a target='_blank' href='http://www.dcc.ac.uk/resources/how-guides/appraise-select-data'>How to appraise and select research data for curation</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Data Selection"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who is responsible for each data management activity?</li> <li>How are responsibilities split across partner sites in collaborative research projects?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Outline the roles and responsibilities for all activities e.g. data capture, metadata production, data quality, storage and backup, data archiving &amp; data sharing. Individuals should be named where possible. For collaborative projects you should explain the co-ordination of data management responsibilities across partners.</p> <p>See UKDS guidance on data management <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/plan/roles-and-responsibilities.aspx'>roles and responsibilities</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Responsibilities"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who may be interested in using your data?</li><li>What are the further intended or foreseeable research uses for the data?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>You should think about the possibilities for reuse of your data in other contexts and by other users, and connect this as appropriate with your plans for dissemination and Pathways to Impact. Where there is potential for reuse, you should use standards and formats that facilitate this. Where possible outline the types of users you expect and estimate numbers.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Expected Reuse"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Who owns the data?</li> <li>How will the data be licensed for reuse?</li><li>If you are using third-party data, how do the permissions you have been granted affect licensing?</li> <li>Will data sharing be postponed / restricted e.g. to seek patents?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>State who will own the copyright and IPR of any new data that you will generate. For multi-partner projects, IPR ownership may be worth covering in a consortium agreement. If purchasing or reusing existing data sources, consider how the permissions granted to you affect licensing decisions. Outline any restrictions needed on data sharing e.g. to protect proprietary or patentable data.</p> <p>See the DCC guide: <a target='_blank' href='http://www.dcc.ac.uk/resources/how-guides/license-research-data'>How to license research data</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["IPR Ownership and Licencing"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul> <li>Will access be tightly controlled or restricted? e.g. by using data enclaves / secure data services</li> <li>Will a data sharing agreement be required?</li> <li>How will the data be licensed for reuse?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Indicate whether external users will be bound by data sharing agreements, licenses or end-user agreements. If so, set out the terms and key responsibilities to be followed. Note how access will be controlled, for example by the use of specialist services. A data enclave provides a controlled secure environment in which eligible researchers can perform analyses using restricted data resources. Where a managed access process is required, the procedure should be clearly described and transparent.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Managed Access Procedures"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul><li>How will you capture / create the metadata?</li><li>Can any of this information be created automatically?</li><li>What metadata standards will you use and why?</li></ul> <p class='guidance_header'>Guidance:</p> <p>Metadata should be created to describe the data and aid discovery. Consider how you will capture this information and where it will be recorded e.g. in a database with links to each item, in a ‘readme’ text file, in file headers etc.</p><p>Researchers are strongly encouraged to use community standards to describe and structure data, where these are in place. The DCC offers a <a target='_blank' href='http://www.dcc.ac.uk/resources/metadata-standards'>catalogue of disciplinary metadata standards</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Metadata"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p><ul><li>What additional resources are needed to deliver your plan?</li> <li>Is additional specialist expertise (or training for existing staff) required?</li><li>Do you have sufficient storage and equipment or do you need to cost in more?</li><li>Will charges be applied by data repositories?</li><li>Have you costed in time and effort to prepare the data for sharing / preservation?</li></ul><p class='guidance_header'>Guidance:</p> <p>Carefully consider any resources needed to deliver the plan. Where dedicated resources are needed, these should be outlined and justified. Outline any relevant technical expertise, support and training that is likely to be required and how it will be acquired. Provide details and justification for any hardware or software which will be purchased or additional storage and backup costs that may be charged by IT services. </p><p>Funding should be included to cover any charges applied by data repositories, for example to handle data of exceptional size or complexity. Also remember to cost in time and effort to prepare data for deposit and ensure it is adequately documented to enable reuse. If you are not depositing in a data repository, ensure you have appropriate resources and systems in place to share and preserve the data.</p> <p>See UKDS guidance on <a target='_blank' href='http://ukdataservice.ac.uk/manage-data/plan/costing.aspx'>costing data management</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Resourcing"]
  },
  {
    text: "<p class='guidance_header'>Questions to consider:</p> <ul><li>Where will the data be stored?</li> <li>How will the data be backed up? i.e. how often, to where, how many copies, is this automated&#8230;</li> <li>Who will be responsible for storage and backup?</li> <li>Do you have access to enough storage or will you need to include charges for additional services?</li> </ul> <p class='guidance_header'>Guidance:</p> <p>Describe how the data will be stored and backed-up to ensure the data and metadata are securely stored during the lifetime of the project. Storing data on laptops, computer hard drives or external storage devices alone is very risky. The use of robust, managed storage with automatic backup, for example that provided by university IT teams, is preferable.</p> <p>See UKDA guidance on <a target='_blank' href='http://data-archive.ac.uk/create-manage/storage.aspx'>data storage and backup</a>.</p>",
    guidance_group: "DCC Guidance",
    themes: ["Storage and Backup"]
  }
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
    }
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
    }
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
    }
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
    }
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
