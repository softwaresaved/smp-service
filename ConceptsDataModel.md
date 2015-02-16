
# DMPonline concepts and data model

---

## Concepts

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

Or:

* Guidances belong to guidance groups and have associated themes.
* Guidance groups belong to organisations.
* Organisations have types.
* Questions belong to sections.
* Sections belong to versions and organisations.
* Versions belong to phases.
* Phases belong to templates.
* Templates have organisations.

---

## Themes

From Appendix 1: Themes used in DMPonline in [Using the DMPonline admin interface: a guide to customising the tool](http://www.dcc.ac.uk/sites/default/files/documents/tools/dmpOnline/DMPonline-admin-interface-guide.pdf), 1.0, 20/06/14.

* ID
* PROJECT DESCRIPTION
* RELATED POLICIES
* EXISTING DATA
* RELATIONSHIP TO EXISTING DATA
* DATA DESCRIPTION
* DATA FORMAT
* DATA VOLUMES
* DATA TYPE
* DATA CAPTURE METHODS
* DATA QUALITY
* DOCUMENTATION
* METADATA
* DISCOVERY BY USERS
* ETHICAL ISSUES
* IPR OWNERSHIP AND LICENCING
* STORAGE AND BACKUP
* DATA SECURITY
* DATA SELECTION
* PRESERVATION PLAN
* PERIOD OF PRESERVATION
* DATA REPOSITORY
* EXPECTED REUSE
* METHOD FOR DATA SHARING
* TIMEFRAME FOR DATA SHARING
* RESTRICTIONS ON SHARING
* MANAGED ACCESS PROCEDURES
* RESPONSIBILITIES
* RESOURCING

---

## Database tables

Created by db/schema.rb.

* active_admin_comments
* admin_users
* answers
* answers_options
* dmptemplates
* dmptemplates_guidance_groups
* exported_plans
* file_types
* file_uploads
* friendly_id_slugs
* guidance_groups
* guidance_in_group
* guidances
* option_warnings
* options
* organisation_types
* organisations
* pages
* phases
* plan_sections
* plans
* project_groups
* project_guidance
* projects
* question_formats
* questions
* questions_themes
* roles
* schema_migrations
* sections
* settings
* splash_logs
* suggested_answers
* themes
* themes_in_guidance
* user_org_roles
* user_role_types
* user_statuses
* user_types
* users
* users_roles
* versions

---

## Database configuration

Populated by db/seeds.rb:

* dmptemplates
  - See templates in seeds.rb
  - title e.g. DCC Template
  - description e.g. The default DCC template
  - published e.g. true
  - organisation e.g. DCC
  - locale e.g. en
  - is_default e.g. true
* guidance_groups
  - name e.g. DCC Guidance 
  - organisation e.g. DCC
  - optional_subset e.g. false
* guidances
  - text
  - guidance_group e.g. DCC Guidance
    - The value is appended to any existing values
  - themes e.g. ["Restrictions on Sharing"]
    - The values are appended to any existing values
  - One entry per Themes above, except for ID and PROJECT DESCRIPTION
  - If user selects DCC Guidance guidance group then they will see a specific guidance if they select a question whose theme is in the list of themes covered by that guidance
* organisation_types
  - name e.g. Organisation, Funder, Project, School, ...
* organisations
  - name e.g. Digital Curation Centre
  - abbreviation e.g. DCC
  - sort_name e.g. Digital Curation Centre
  - organisation_type e.g. Organisation
  - domain (not for all) e.g. www.gla.ac.uk (not for all)
* phases
  - title e.g. DCC Template 
  - number e.g. 1
  - template e.g. DCC Template
* question_formats
  - title e.g. Text area, Radio button, ...
* questions
  - text
  - section e.g. Data Collection
  - number e.g. 1
  - guidance e.g. "...HTML..."
  - themes e.g. ["Existing Data", "Data Volumes", "Data Type", "Data Format"]
    - The values are appended to any existing values
* sections
  - title e.g. Data Collection
  - number e.g. 1
  - description 
  - version e.g. "DCC Template Version 1"
  - organisation e.g. "DCC"
* settings
  - See formatting in seeds.rb
  - Adds entries to settings e.g.
  - id: 1 (auto-generated)
  - var: export
  - value: formatting: font_face... ... ... 
  - target_id: 2
  - target_type: Dmptemplate
  - created_at: 2015-02-12 13:32:23
  - updated_at: 2015-02-12 13:32:23
* themes
  - title e.g. Related Policies, Preservation Plan, Project Name, ...
  - locale e.g. en
  - description (not for all)
  - One entry per Themes above, plus Project Name and PI / Researcher
* versions
  - title e.g. DCC Template Version 1
  - number e.g. 1
  - phase e.g. DCC Template

DCC Template Version 1 has 7 sections:

* Data Collection
* Data Sharing
* Documentation and Metadata
* Ethics and Legal Compliance
* Responsibilities and Resources
* Selection and Preservation
* Storage and Backup

DCC Template Version 1 sections has 13 questions:

* What data will you collect or create?
  - section: "Data Collection"
  - themes: ["Existing Data", "Data Volumes", "Data Type", "Data Format"]
* How will the data be collected or created?
  - section: "Data Collection"
  - themes: ["Data Capture Methods", "Data Quality"]
* What documentation and metadata will accompany the data?
  - section: "Documentation and Metadata"
  - themes: ["Documentation", "Metadata"]
* How will you manage any ethical issues?
  - section: "Ethics and Legal Compliance"
  - themes: ["Ethical Issues"]
* How will you manage copyright and Intellectual Property Rights (IPR) issues?
  - section: "Ethics and Legal Compliance"
  - themes: ["IPR Ownership and Licencing"]
* How will the data be stored and backed up during the research?
  - section: "Storage and Backup"
  - themes: ["Storage and Backup"]
* How will you manage access and security?
  - section: "Storage and Backup"
  - themes: ["Data Security"]
* Which data are of long-term value and should be retained, shared, and/or preserved?
  - section: "Selection and Preservation"
  - themes: ["Data Selection"]
* What is the long-term preservation plan for the dataset?
  - section: "Selection and Preservation"
  - themes: ["Preservation Plan", "Data Repository"]
* How will you share the data?
  - section: "Data Sharing"
  - themes: ["Method For Data Sharing"]
* Are any restrictions on data sharing required?
  - section: "Data Sharing"
  - themes: ["Restrictions on Sharing"]
* Who will be responsible for data management?
  - section: "Responsibilities and Resources"
  - themes: ["Responsibilities"]
* What resources will you require to deliver your plan?
  - section: "Responsibilities and Resources"
  - themes: ["Resourcing"]

The themes unused in the above are:

* ID
* PROJECT DESCRIPTION
* RELATED POLICIES
* RELATIONSHIP TO EXISTING DATA
* DATA DESCRIPTION
* DISCOVERY BY USERS
* PERIOD OF PRESERVATION
* EXPECTED REUSE
* TIMEFRAME FOR DATA SHARING
* MANAGED ACCESS PROCEDURES

What this sets up:

* 6 organisation types.
* 3 organisations, one of which is DCC.
* 29 themes (27 plus Project Name and PI / Researcher).
* 6 question formats.
* 1 guidance group, DCC Guidance, for DCC organisation.
* 27 guidances, for DCC guidance group.
* 2 templates, one of which is DCC Template for DCC organisation.
* 2 phases, one of which is DCC Template for DCC Template.
  - So DCC Template template has 1 phase.
* 2 versions, one of which is DCC Template Version 1 for DCC Template phase.
* 7 sections, all for DCC Template Version 1 and DCC organisation.
* 13 questions, for sections above, and using themes

---

## DMPonline super-admin dashboard

* Guidance list
 - Guidance
 - Guidance Group
* Organisations management
 - Organisation type
 - Organisation
* Project Groups
* Templates management
 - Multiple question options
 - Phase
 - Question
 - Question Format
 - Section
 - Suggested answer
 - Version
 - Template
* User management
 - Role
 - User role on an Organisation
 - User role type
 - User status
 - User type
 - User
* Themes
* Plans
