class Question < ActiveRecord::Base

  #associations between tables
  has_many :answers, :dependent => :destroy
  has_many :options, :dependent => :destroy
  has_many :suggested_answers, :dependent => :destroy

  belongs_to :section
  belongs_to :question_format

  accepts_nested_attributes_for :answers, :reject_if => lambda {|a| a[:text].blank? },  :allow_destroy => true
  accepts_nested_attributes_for :section
  accepts_nested_attributes_for :question_format
  accepts_nested_attributes_for :options, :reject_if => lambda {|a| a[:text].blank? },  :allow_destroy => true
  accepts_nested_attributes_for :suggested_answers,  :allow_destroy => true

  attr_accessible :default_value, :dependency_id, :dependency_text, :guidance,
  								:number, :parent_id, :suggested_answer, :text, :section_id,
  								:question_type, :multiple_choice,
  								:multiple_permitted, :is_expanded, :is_text_field,
  								:question_format_id,
  								:options_attributes,
  								:suggested_answers_attributes

	def to_s
    "#{text}"
  end

	amoeba do
    include_field :options
    include_field :suggested_answers
  end

	def question_type?
		type_label = {}
		if self.is_text_field?
		  type_label = 'Text field'
		elsif self.multiple_choice?
			type_label = 'Multiple choice'
		else
			type_label = 'Text area'
		end
		return type_label
	end

 	#get suggested answer belonging to the currents user for this question
 	def get_suggested_answer(org_id)
 		suggested_answer = suggested_answers.find_by_organisation_id(org_id)
 		return suggested_answer
 	end
end
