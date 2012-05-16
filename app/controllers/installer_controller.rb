class InstallerController < ApplicationController
before_filter :login_required
before_filter :installer_required # You must have a user_right of "Installer"

	def index
	end

#	def new
#		@installer = Installer.new(params[:installer])
#		if request.post?
#			# Create their password
#			@password = random_password
#			@password_hash = Digest::SHA1.hexdigest(@password)
#			@installer.password = @password_hash
#					
#			if @installer.save
#
#				flash[:notice] = "Your application has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @#installer.email + "</B></Font> with your password and additional instructions." + @password
#				Emailer.deliver_installer_application("#{@installer.company_name}", "#{@installer.first_name}", "{@installer.last_name}", "#{@installer.email}", "#{@password}")
#				Emailer.deliver_installer_application_notify("#{@installer.company_name}", "#{@installer.first_name}", "#{@installer.last_name}", "#{@installer.email}", "#{@installer.id}", "#{@installer.applicant_comments}")
#	
#				redirect_to :controller => 'main', :action => 'index'
#			end
#		end	
#	end


	def new_borrower
		if request.post?
			@borrower = Borrower.new(params[:borrower])
#			@user = User.new

			# Record this lender's ID in the borrower record
			@borrower.installer_id = session[:current_user_installer_id]
			@borrower.status = "SubmittedByInstaller"

			# Create the password for the URL
			password = @borrower.email.to_s + "secret" + @borrower.installer_id.to_s
			@password_hash = Digest::SHA1.hexdigest(password)

			# Create their password
#			password = random_password
#			@password_hash = Digest::SHA1.hexdigest(password)
#			@user.password = @password_hash
#			@user.borrower_id = @borrower_application.id
#			@user.user_type = "borrower"

#			if @borrower.save && @user.save && @borrower.update_attribute(:user_id, @user.id)
			if @borrower.save
				flash[:notice] = "The application for #{@borrower.first_name} #{@borrower.last_name} has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @borrower.email + "</B></Font> with additional information."

				Emailer.deliver_borrower_submitted_by_installer_application("#{@borrower.first_name}", "#{@borrower.last_name}", "#{@borrower.email}", "#{@borrower.id}", "#{@borrower.installer_id}", "#{@password_hash}")
				Emailer.deliver_borrower_submitted_by_installer_application_notify("#{@borrower.first_name}", "#{@borrower.last_name}", "#{@borrower.email}", "#{@borrower.id}", "#{@borrower.installer_id}")
				redirect_to :controller => 'installer', :action => 'index'
			end
		end
	end

	def list_borrower_invitations
		@borrower_invitations = Borrower.find(:all, :conditions => {:status => ["SubmittedByInstaller", "Under Review"], :installer_id => session[:current_user_installer_id]})
	end


end