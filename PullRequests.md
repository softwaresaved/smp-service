# DMPonline pull requests

Summary of changes fed back to DMPonline as pull requests. 

Most of these were rationally reconstructed from changes made when [Customing DMPonline into a prototype SMP service](./CustomiseDMPonlineForSMP.md) on the [smp-prototype](https://github.com/softwaresaved/smp-service/tree/smp-prototype) branch up to commit [58f9acebf3a8879dac75a0238924f93176246317](https://github.com/softwaresaved/smp-service/commit/58f9acebf3a8879dac75a0238924f93176246317) of 18 Mar 2015.

The version of DMPonline used as a basis for these changes was the latest at the time of writing, master branch, commit [6236385f55189be55f2b470b5ee3563615d964c1](https://github.com/DigitalCurationCentre/DMPonline_v4/commit/6236385f55189be55f2b470b5ee3563615d964c1) 24 Nov 2014.

| Branch | Pull Request |
| ------ | ------------ |
| [add_licence](https://github.com/softwaresaved/smp-service/tree/add_licence) | [160](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/160) |
| [config_properties](https://github.com/softwaresaved/smp-service/tree/config_properties) | [167](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/167) |
| [configurable_map](https://github.com/softwaresaved/smp-service/tree/configurable_map) | Merged into config_properties. |
| [dmp_agnostic](https://github.com/softwaresaved/smp-service/tree/dmp_agnostic) | [166](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/166)
| [fix_recaptcha_flash](https://github.com/softwaresaved/smp-service/tree/fix_recaptcha_flash) | [161](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/161) |
| [fix-seeds](https://github.com/softwaresaved/smp-service/tree/fix-seeds) | Merged into fix-seeds-extended. |
| [fix-seeds-extended](https://github.com/softwaresaved/smp-service/tree/fix-seeds-extended) | [169](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/169) |
| [fix-unit-tests](https://github.com/softwaresaved/smp-service/tree/fix-unit-tests) | [168](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/168) |
| [generic_favicon](https://github.com/softwaresaved/smp-service/tree/generic_favicon) | [162](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/162) |
| [htmltoword018](https://github.com/softwaresaved/smp-service/tree/htmltoword018) | [163](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/163) |
| [index_403_consistent](https://github.com/softwaresaved/smp-service/tree/index_403_consistent) | [165](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/164) |
| [toggle_shibboleth](https://github.com/softwaresaved/smp-service/tree/toggle_shibboleth) | [165](https://github.com/DigitalCurationCentre/DMPonline_v4/pull/165) |

The following is lists each commit on smp-prototype up to commit 58f9acebf3a8879dac75a0238924f93176246317 of 18 Mar 2015 and maps these to the branches above.

| Status | Branch | smp-prototype commit |
| ------ | ------ | -------------------- |
| DONE | fix-seeds-extended | 58f9acebf3a8879dac75a0238924f93176246317 Added roles initialisation and admin, org_admin roles |
| N/A | - | 3625b5fc0835aafae2442aef74fa4bbae73be0de Reworded disclaimers and elaborated on advice as it relates to copyright, licensing, IP |
| N/A | - | b672b31f53dff2d3a3be57987c7b25ff92ff36eb Shortened 'prototype service' message |
| N/A | - | a70de5628bd5e30f50fe8dc1193c0ee97e6f9895 Updated description of default SSI template to reflect addition of SSI Extended Template |
| N/A | - | 4358c5c42f9a198c83535c1eead9e43d7da33a85 Created SSI Extended Template with refactored categories, questions for consideration and advice |
| DONE | fix-seeds-extended | 2f2b9bbe35c57025f0053c6e148e58e0d790b69f Streamlined seeds.db to reduce information duplication when configuring templates, phases, versions, sections, questions, formatting |
| N/A | - | db2e3e14fd24bc4bc489f3eb4759ad22ed7bf47c Removed DCC themes, guidance_groups and guidance from seeds.rb |
| DONE | fix-seeds-extended | a65df1f2fbc696edddaf81a02e9dbebf57d9b680 Refactored how database is populated - based on lists rather than keys so questions and sections can have the same text for different templates |
| DONE | fix-seeds-extended | cdbb928a182f5724fcb88af94579fbe619c0167b Introduced some radiobutton/checkbox questions |
| N/A | - | 3dd2a08e82efdbe35f0ef13a412ce55a6c2967dd Renamed 'SSI Template' phase to 'SSI Sample SMP' |
| N/A | - | 835b1bb56b748e5b7bf2f74905131a2ed2c6639c Changed .home_name font-family from Courier to Consolas to match SSI logo |
| N/A | - | 98f8ec44a630ffb2f3f020e165b6fb90660f1353 Initial port of software management plan guide into seeds.rb |
| N/A | - | 3a75c77f2d88bcd2dd77a9cf529b63a34e41b3c9 Changed e-mails from michaelj to info@software.ac.uk |
| N/A | - | 926c58ff3d752a31733c4393696bc2c64888ad65 Removed port number from Generated by |
| DONE | genric_favicon | 0e29256e38486ea86342dcaa461cdccc04594d5b dmponline_favicon.ico => favicon.ico |
| DONE | generic_favicon | 683250843fccafb308e240b4ff6b733b77f5f02e dmponline_favicon.ico => favicon.ico |
| DONE | genric_favicon | 7e5180c032bd889a45f9a58056e676465a862a47 Updated with SSI favicon.ico |
| N/A | - | 06e753e4b41d9088d5036acb57366ee24364b102 Added prototype motivations, disclaimers, link to issue tracker |
| DONE | fix_recaptcha_flash | d550325c55b40fa0d8a1319d65a25ddf9559d10a Replaced flash[:error] with flash[:alert] so the flashes appear on the title screen |
| DONE | htmltoword018 | 3ddd70fa0f68e7fecb9ce0463d3ab4b84ca73ecc Set htmltoword to 0.1.8 due to problems with 0.2.0 and missing XSLT |
| N/A | - | db7feaa994a7f9ada433edb12b59c3b3c44b4b21 Added SSI logo, logo.png and smaller version of DMPonline logo, DMPonlineLogo.jpg. Updated header and footer to present SSI, and tool_title from en.yml and changed styles to present these OK |
| N/A | - | 5cd58d0c073fd4fa4ed2593c36bae7abe70506f1 Updated to use SSI colour scheme |
| N/A | - | e0c804e5dc87213fb6e4a686801d588df4817885 Added The University of Edinburgh as copyright holder for 2015 |
| DONE | index_403_consistent | Consistent in appearence and content to public/403.html |
| N/A | - | 5c645a327b3e16ec60141a00347da4b1bb4193e1 Removed redundant quote |
| N/A | - | ded693cae486fe84efdc43edce6b6a4e0bd4bb41 Updated contact e-mail for problems |
| N/A | - | | 820ef77e150d93f1bcdcb87db78373b910534f28 Removed screencast-home-page div block |
| N/A | - | 6d691d6ebb7ff4d4cf823605f6734801a872875c Removed News link |
| DONE | configurable_map and config_properties  | 2f6d48e653b53726d43880c26e16d233cd474702 Added map_url to config/locales/en.yml for consistency with how address is inserted into new.html.erb |
| N/A | - | | 66ce99ecf778ec9514f2ebced82dc26b0d9759f2 Updated GoogleMap to show James Clark Maxwell Building, UoE |
| DONE | config_properties | b2a41e8c7119f274032ca2601e1db24835a0d629 Updates to allow more configuration of UI and e-mail text to be done via config/locales/en.yml. |
| DONE | dmp_agnostic | d81af43b30a303e3f7194818b97a3a607b7197af Renamed link anchors to be SMP and DMP agnostic |
| DONE | dmp_agnostic | 84da8b679cfafbfbf7c1a5120844875657c55abc Reworded 'access to the SMP NNNN' to 'access to NNNN' so these files are SMP and DMP agnostic |
| DONE | toggle_shibboleth | af8d9befa11488f4adc1fbb56962b47bf77efc27 Changed use of DMPonline4::Application to Rails.application |
| N/A | - | bd65b4873644c2614e9097be1ba53821d6bc50da Updated localisation information in config/locales/en.yml   |
| N/A | - | 5aa5adb3d5b6fbec44764321ab9788cf892eff5b Fixed broken link. |
| N/A | - | 8f251a611c51d7ede8add21b864a4a7cea716b9f Fixed broken link and added Affero link |
| N/A | - | dbd9dc212e038f92ec662186b480cbef792eda32 Rewrote to serve as a README for Software Management Plan Service |
| DONE | add_license | 6fb1d1870195647aad58f5e7c0d4de2f5110ff6b Added GNU Affero GPL file |
| N/A | - | 838b5638a6a778e2f63cbb17e15fd529a5812350 Removed HTML text and links about DMPonline 3 |
| N/A | - | e4392164132316c3a7d1ca7e034e64a46f64b8ad Default value of config.shibboleth_enabled set to false |
| DONE | toggle_shibboleth | 0bc7b24f560ea8cfaf4fa96b6cc141ca82b4818a Added conditionals based on DMPonline4::Application.config.shibboleth_enabled flag so that Shibboleth-specific links are only presented if this flag is true |
| DONE | config_properties and dmp_agnostic | 24c99223837b694784ac9ac205f518fe4d6cacdf | Name replacements in HTML fragments and Ruby strings presented on the user interface, or in e-mails: DMPonline -> Software Management Plan Service, Data Management Plan -> Software Management Plan, DMP -> SMP. config/locales/en.yml was NOT touched as that overlaps with institution-specific branding |
| DONE | fix-seeds | eaea66804be50feaab12a5b01b58a6121eef94c2 Merged in AHRC Template 419adebe0f01877f78984d4e3c64168dd4565019 |
| DONE | fix-seeds | 065fbd33b758e9b952e2e02cce97f59cb5a4c7b1 version.published initialised to value of dmptemplate.published of dmptemplate to which it belongs |
| DONE | fix-seeds | ce59c666ae4732497f66147e82e3d0eaf99b7f7c Bug fix: sections now initialises organisation using Organisation.find_by_abbreviation not find_by_name |
| DONE | fix-seeds | 0a2f83caad79ca284bf693f9547e29e744574437 Added default format values to questions |
| DONE | fix-seeds | b342163897f76e7fd6067ec526cb94ca233b0eb DMPonline_v4/6791c19e751560ac9a18d3bb80f8ff21bc31ff39/db/seeds.rb as recommended in https://github.com/DigitalCurationCentre/DMPonline_v4/wiki/1.-Local-Installation |
| START | - | 6236385f55189be55f2b470b5ee3563615d964c1 additional text about confirmation email |
