
# Customing DMPonline into a prototype SMP service

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 13/02/2014.

## Introduction

Notes on the changes that need to be made to [DMPonline](https://github.com/DigitalCurationCentre/DMPonline_v4) to use it as a prototype service for software management plans.

The version of DMPonline used as a basis of this document was the latest at the time of writing, master branch, commit [6236385f55189be55f2b470b5ee3563615d964c1](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/6236385f55189be55f2b470b5ee3563615d964c1) 24 Nov 2014.

---

## DMPonline concepts and data model

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
  - Consists of one or more sections.
* Section:
  - Consists of one or more questions.
* Question:
  - Has 1 or more associated themes.
  - Has question-specific guidance.

We can map concepts from software management plans into the above concepts. So, using the Institute's guide on [Writing and using a software management plan](http://www.software.ac.uk/resources/guides/software-management-plans) as a source of SMP-related content:

* Themes:
  - There is no reason why SMP-related information cannot be grouped into themes also.
  - Some themes from DMPs also relate to SMPs e.g. Documentation, Discovery by Users, Ethical Issues, IPR Ownershop and Licencing etc.
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

## DMPonline data

Database tables to hold all this information are created by db/schema.rb. As mentioned, we don't need to worry about the database schema since it is not exposed to users. 

The database is populated via a file, db/seeds.rb. This defines the information as presented to the user and editing this file we can change what information is presented to users. 

---

## Don't worry about what the user can't and won't see

DMPonline's code contains myriad references to data management plans, data and DMPs. For example:

* Database table and column names.
* Class, function and variable names.
* File names.
* URL paths.

As these are not exposed to users, for the purposes of prototyping an SMP service they will be left as-is. There are two reasons for this:

* To reduce the time to develop the prototype.
* To limit the divergence between the SMP service code and DMPonline.

While URL paths are visible to the users, it can be assumed that these do not form part of the user's interface.

The file DesktopDMPquestions_table.sql is also ignored as it is unused by the DMPonline code.

---

## DMPonline presentation

The following accompanying files list those files that determine the presentation of DMPonline:

* [code-dmp-data.txt](./code-dmp-data.txt) - references to "DMP" and "data".
* [code-images.txt](./code-images.txt) - references to DCC logos, DCC-branded icons and movies.

These files need to be edited so that, for example, references to data management plans and DMPs are replaced by references to software management plans or SMPs.

---

## Additional deferred features for a prototype

The following features are not needed for a prototype:

* Shibboleth authentication.
* ORCID.

code-dmp-data.txt above also lists references to "orcid" and "shibboleth" within DMPonline code.

The relevant views/ files can be updated to hide these features from users.

---

## Evaluating the prototype 

In any evaluation, users should be asked to notify us of any stray references to DMPs or data management plans that may have slipped through.
