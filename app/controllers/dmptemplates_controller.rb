class DmptemplatesController < ApplicationController

  # GET /dmptemplates
  # GET /dmptemplates.json
  def admin_index
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # GET /dmptemplates/1
  # GET /dmptemplates/1.json
  def admin_template
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # PUT /dmptemplates/1
  # PUT /dmptemplates/1.json
  def admin_update
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # GET /dmptemplates/new
  # GET /dmptemplates/new.json
  def admin_new
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # POST /dmptemplates
  # POST /dmptemplates.json
  def admin_create
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # DELETE /dmptemplates/1
  # DELETE /dmptemplates/1.json
  def admin_destroy
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

  # PHASES

  #show and edit a phase of the template
  def admin_phase
  end
	
  #preview a phase
  def admin_previewphase
  end

  #add a new phase to a template
  def admin_addphase
  end

  #create a phase
  def admin_createphase
  end

  #update a phase of a template
  def admin_updatephase
  end

  #delete a version, sections and questions
  def admin_destroyphase
  end

  # VERSIONS
  
  #update a version of a template
  def admin_updateversion
  end

  #clone a version of a template
  def admin_cloneversion
  end

  #delete a version, sections and questions
  def admin_destroyversion
  end

  # SECTIONS

  #create a section
  def admin_createsection
  end

  #update a section of a template
  def admin_updatesection
  end

  #delete a section and questions
  def admin_destroysection
  end

  #  QUESTIONS

  #create a question
  def admin_createquestion
  end

  #update a question of a template
  def admin_updatequestion
  end

  #delete a version, sections and questions
  def admin_destroyquestion
  end

  #SUGGESTED ANSWERS
  #create suggested answers
  def admin_createsuggestedanswer
   end

  #update a suggested answer of a template
  def admin_updatesuggestedanswer
  end
  
  #delete a suggested answer
  def admin_destroysuggestedanswer
  end
end
