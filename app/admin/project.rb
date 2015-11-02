ActiveAdmin.register Project do
	
	 menu :priority => 25, :label => proc{I18n.t('admin.plans')}


	#:dmptemplate_id, :locked, :note, :title, :organisation_id, :unit_id, :project_group_ids, :funder_id, :institution_id, 
	#:grant_number,:identifier, :description, :principal_investigator, :principal_investigator_identifier, :data_contact
	
	index do  
		column :title
		column I18n.t('admin.org_title'), :sortable => :organisation_id do |org_title|
            if !org_title.organisation.nil? then
                link_to org_title.organisation.name, [:admin, org_title.organisation]
            else
                '-'
            end
        end
		column I18n.t('admin.template_title'), :sortable => :dmptemplate_id do |dmptemp|
            if !dmptemp.dmptemplate.nil? then
                link_to dmptemp.dmptemplate.title, [:admin, dmptemp.dmptemplate]
            else
                '-'
            end
        end
	    	
        default_actions
    end
end
