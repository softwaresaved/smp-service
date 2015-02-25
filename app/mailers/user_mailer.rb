class UserMailer < ActionMailer::Base
	default from: 'info@dcc.ac.uk'
	
	def sharing_notification(project_group)
		@project_group = project_group
		mail(to: @project_group.user.email, subject: "You have been given access to a Software Management Plan")
	end
	
	def permissions_change_notification(project_group)
		@project_group = project_group
		mail(to: @project_group.user.email, subject: "SMP permissions changed")
	end
	
	def project_access_removed_notification(user, project)
		@user = user
		@project = project
		mail(to: @user.email, subject: "SMP access removed")
	end
end
