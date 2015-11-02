ActiveAdmin.register Question do

	menu :priority => 1, :label => proc{I18n.t('admin.question')}, :parent =>  "Templates management"

	index do  #:default_value, :dependency_id, :dependency_text, :number, :parent_id, 
		#:suggested_answer, :text, :question_type, :section_id
        column I18n.t('admin.question'), :sortable => :text do |descr|
            if !descr.text.nil? then
                descr.text.html_safe
            end
        end	
        column I18n.t('admin.section_title'), :sortable => :section_id do |dmptemplate|
            if !dmptemplate.section_id.nil? then
                 link_to dmptemplate.section.title, [:admin, dmptemplate.section]
            end
        end
        column :number, :sortable => :number do |question_n|
            if !question_n.number.nil? then
             question_n.number
            end 
        end
        column I18n.t('admin.template_title'), :sortable => true do |dmptemplate|
             if !dmptemplate.section_id.nil? then
            link_to dmptemplate.section.version.phase.dmptemplate.title, [:admin, dmptemplate.section.version.phase.dmptemplate]
           end 
        end
        default_actions
    end
  
  
    #show details of a question
	show do
		attributes_table do
			row	:text do |descr|
                if !descr.text.nil? then
                    descr.text.html_safe
                end
            end	
	 		row :section_id do |question|
                link_to question.section.title, [:admin, question.section]
            end
	 		row :number
	 		row :default_value
	 		row I18n.t('admin.question_format') do |format|
	 			link_to format.question_format.title, [:admin, format.question_format]
	 		end
	 		row :guidance do |qguidance|
                if !qguidance.guidance.nil? then
                    qguidance.guidance.html_safe
                end
            end	
            row :parent_id do |qparent|
                if !qparent.parent_id.nil? then
                    parent_q = Question.where('id = ?', qparent.parent_id)
                    link_to parent_q.text, [:admin, parent_q]
                end
            end
            row :dependency_id do |qdepend|
                if !qdepend.dependency_id.nil? then
                    qdep = Question.where('id = ?', qparent.dependency_id)
                    link_to qdep.text, [:admin, qdep]
                end
            end
            row :dependency_text do |dep_text|
                if !dep_text.dependency_text.nil? then
                    dep_text.dependency_text.html_safe
                end
            end	
            row :created_at
            row :updated_at
	 		
	 	end	
	end


	#form 
    form do |f|
        f.inputs "Details" do
            f.input :text
            f.input :number
            f.input :section, 
  					:as => :select, 
  					:collection => Section.find(:all, :order => 'title ASC').map{ |sec| ["#{sec.version.phase.dmptemplate.title} - #{sec.title}", sec.id] }
            f.input :default_value
            f.input :guidance 
            f.input :parent_id, :label => "Parent", 
  					:as => :select, 
  					:collection => Question.find(:all, :order => 'text ASC').map{|que|[que.text, que.id]}
            f.input :dependency_id, :label => "Dependency question", 
  					:as => :select, 
  					:collection => Question.find(:all, :order => 'text ASC').map{|que|[que.text, que.id]}
            f.input :dependency_text
            f.input :multiple_choice
            f.input :multiple_permitted
            f.input :is_text_field
            f.input :is_expanded  	
        end
        f.inputs "Question Format" do
  			f.input :question_format_id, :label => "Select question format",
  					:as => :select,
  					:collection => QuestionFormat.order('title').map{|format| [format.title, format.id]}								
        end
	 	f.actions  
    end	


end
