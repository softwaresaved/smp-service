
# DMPonline testing experiences

Mike Jackson, [The Software Sustainability Institute](http://www.software.ac.uk), 23/02/2014.

## Introduction

It can be useful for deployers to run automated tests to ensure that they that they pre-requisite software has been installed correctly, and that, if using a version from a source code repository, the code they have downloaded works correctly.

This document summarises experiences in running automated tests for DMPonline. This complements [DMPonline deployment and usage experiences](./DMPonlineDeployUseReview.md).

---

## Unit tests

The tests, located in tests/unit, were run:

    $ rake db:test:load
    $ rake test:units

### questions.yml suggested_answer

Every unit test failed.

    21 tests, 0 assertions, 0 failures, 21 errors, 0 skips

The problem, in every case, was:

    ActiveRecord::StatementInvalid: Mysql2::Error: Unknown column
    'suggested_answer' in 'field list': INSERT INTO `questions` (`text`,
    `guidance`, `suggested_answer`, `number`, `created_at`, `updated_at`,
    `id`, `section_id`) VALUES ('Digital Information', '<p>Enter a brief
    description of the activities that will produce the data.</p>',
    '<table><tr> <th>Dataset Description</th> <th>Contact Dataset</th>
    <th>Data Volume</th> <th>Data Format</th> <th>Issues</th> <th>Delivery
    Date</th> <th>Embargo Date</th> <th>Reuse Scenario</th>
    <th>Preservation Plan</th> </tr><tr> <td></td> <td></td> <td></td>
    <td></td> <td><em>Any issues with the data, e.g. legal, access,
    retention, etc.</em></td> <td><em>Date expect to receive
    data</em></td> <td><em>No more than two years after delivery</em></td>
    <td></td> <td><em>e.g. Keep indefinitely, Do not keep, etc. including
    destination data centre (if not owning data centre)</em></td>
    </tr></table>', 1, '2015-02-23 14:29:40', '2015-02-23 14:29:40',
    497673076, 1407227) 

The problem is due to the initialisation of the database with text fixtures. One of the test fixtures files, test/fixtures/questions.yml, defines values for the suggested_answers field of the questions database table e.g.:

    nerc_2_8_1:
      text: Digital Information
      guidance: "<p>Enter a brief description of the activities that will produce the data.</p>"
      suggested_answer: "..."
      number: 1
      section: nerc_2_8
      themes: data_capture_methods, ...

However the current DMPonline database schema for questions does not support that field. Removing these suggested_answers fields from questions.yml caused all but 3 of the tests to pass.

After applying the above fix, three unit tests still failed.

See [smp-service fix-unit-tests](https://github.com/softwaresaved/smp-service/tree/fix-unit-tests) branch, commit [3030516874cf3b8e205029642afbb51231a8feea](https://github.com/softwaresaved/smp-service/commit/3030516874cf3b8e205029642afbb51231a8feea).

### test_setting_non-integer_as_font_size_should_not_be_valid

This test, within test/unit/dmptemplate_test.rb fails with error:
    
    test_setting_non-integer_as_font_size_should_not_be_valid(DmptemplateTest):
    NoMethodError: undefined method `to_i' for :foo:Symbol
        app/models/settings/dmptemplate.rb:73:in `block in <class:Dmptemplate>'
    
The problem arises from this line in app/models/settings/dmptemplate.rb:
    
    self.formatting[:font_size] = self.formatting[:font_size].to_i if self.formatting[:font_size].present?
    
which tries to invoke to_i on :foo, the value passed from the test:

    test "setting non-integer as font_size should not be valid" do
      @font_size = :foo
    
The problem can be replicated via the Ruby command line e.g.
    
    2.0.0-p247 :009 >   "123".to_i
     => 123
    2.0.0-p247 :010 > "aaa".to_i
     => 0
    2.0.0-p247 :011 > :foo.to_i
    NoMethodError: undefined method `to_i' for :foo:Symbol
            from (irb):11
            from /disk/ssi-dev0/home/mjj/.rvm/rubies/ruby-2.0.0-p247/bin/irb:12:in `<main>'
    
Changing the test to set:
   
    @font_size = "foo"
    
ensures the test passes.

See [smp-service fix-unit-tests](https://github.com/softwaresaved/smp-service/tree/fix-unit-tests) branch, commit [7c61ef2e6c0176ed59eddde7b0b96a632feaca7c](https://github.com/softwaresaved/smp-service/commit/7c61ef2e6c0176ed59eddde7b0b96a632feaca7c).

### test_not_setting_margin_should_not_be_valid

This test, within test/unit/dmptemplate_test.rb fails with error:

    test_not_setting_margin_should_not_be_valid(DmptemplateTest):
    NoMethodError: undefined method `each' for nil:NilClass
        app/models/settings/dmptemplate.rb:74:in `block in <class:Dmptemplate>'
    
The problem arises from this line in app/models/settings/dmptemplate.rb:
    
    self.formatting[:margin].each do |key, val|
    
which tries to invoke each on self.formatting[:margin], but if this is undefined, as it is in the test, then the error occurs. Adding a nil? check on the value fixes this error:
    
    unless self.formatting[:margin].nil?
      self.formatting[:margin].each do |key, val|
        self.formatting[:margin][key] = val.to_i
      end
    end


See [smp-service fix-unit-tests](https://github.com/softwaresaved/smp-service/tree/fix-unit-tests) branch, commit [c7f7c78539f3e2454fbaacb159ac6d2394acb686](https://github.com/softwaresaved/smp-service/commit/c7f7c78539f3e2454fbaacb159ac6d2394acb686).

### test_setting_non-hash_as_margin_should_not_be_valid

This test, within test/unit/dmptemplate_test.rb fails with error:
    
    test_setting_non-hash_as_margin_should_not_be_valid(DmptemplateTest):
    NoMethodError: undefined method `each' for :foo:Symbol
        app/models/settings/dmptemplate.rb:75:in `block in <class:Dmptemplate>'
    
The problem arises from this line in app/models/settings/dmptemplate.rb:
    
    self.formatting[:margin].each do |key, val|
    
which tries to invoke each on :foo, the value that self.formatting[:margin] is given by the test. Adding a is_a?(Hash) check fixes the bug.
    
    unless self.formatting[:margin].nil? or (not self.formatting[:margin].is_a?(Hash))
      self.formatting[:margin].each do |key, val|
        self.formatting[:margin][key] = val.to_i
      end
    end

See [smp-service fix-unit-tests](https://github.com/softwaresaved/smp-service/tree/fix-unit-tests) branch, commit [3d896490de0b61d91d75419198d51e063432e7af](https://github.com/softwaresaved/smp-service/commit/3d896490de0b61d91d75419198d51e063432e7af).

## Empty unit test classes

Of all the test classes in test/unit, all but:

    dmptemplate_test.rb
    plan_test.rb
    user_test.rb

were empty classes of form:

    require 'test_helper'

    class CLASSNAMETest < ActiveSupport::TestCase
      # test "the truth" do
      #   assert true
      # end
    end

Glancing at the test files, without inspecting their contents, gives a false impression as to the extent of unit tests available. It may be worth considering either implementing these tests, or just deleting these test classes as they do nothing.

---

## Functional tests

The tests, located in tests/functional, were run:

    $ rake test:functionals

Every functional test failed:

    169 tests, 0 assertions, 0 failures, 169 errors, 0 skips

### No fixture with name 'one' found for table 'TABLE'

154 errors followed the pattern:

    StandardError: No fixture with name 'one' found for table 'answers'

The table named in the error differed according to the associated functional test. Looking at the corresponding test fixtures (e.g. test/fixtures/answers.yml) showed that the test data had been commented out:

    #one:
    #  text: MyText
    #  plan_id: 1
    #  user_id: 1
    #  question_id: 1
    #
    #two:
    #  text: MyText
    #  plan_id: 1
    #  user_id: 1
    #  question_id: 1

### undefined method 'authenticate'

1 error was thrown by test/functional/home_controller_test.rb:

    test_should_get_index(HomeControllerTest):
    NoMethodError: undefined method `authenticate' for nil:NilClass

This might be caused by a missing method in app/controllers/home_controller.rb.

### undefined method 'project_partners'

7 identical errors were thrown by test/functional/project_partners_controller_test.rb e.g.:

    test_should_create_project_partner(ProjectPartnersControllerTest):
    NoMethodError: undefined method `project_partners' for #<ProjectPartnersControllerTest:0x000000062b0060>

The database migration db/migrate/20130731131846_drop_project_partners.rb removes the project_partners table, which implies this functional test is no longer applicable.

### undefined method 'question_themes'

7 identical errors were thrown by test/functional/question_themes_controller_test.rb e.g.:

    test_should_create_question_theme(QuestionThemesControllerTest):
    NoMethodError: undefined method `question_themes' for #<QuestionThemesControllerTest:0x00000006733ab0>

There is no QuestionThemesController class, nor a QuestionThemes model class, though there is a questions_themes database table.
