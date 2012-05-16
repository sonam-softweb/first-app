class AppController < ApplicationController

	def borrower
		@borrower = Borrower.find(params[:id])
	end

	def borrower_process
		@borrower = Borrower.find(params[:id])
		@borrower.status = "Under Review"
		if params[:p] == Digest::SHA1.hexdigest(@borrower.email.to_s + "secret" + @borrower.installer_id.to_s) && @borrower.update_attributes(params[:borrower]) 
			flash[:notice] = "Your application has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @borrower.email + "</B></Font> with additional information."
			Emailer.deliver_borrower_application("#{@borrower.first_name}", "#{@borrower.last_name}", "#{@borrower.email}")
			Emailer.deliver_borrower_application_notify("#{@borrower.first_name}", "#{@borrower.last_name}", "#{@borrower.email}", "#{@borrower.id}")
			redirect_to :controller => 'main', :action => 'index'
		end
	
	end

	def lender
		@lender = Lender.new(params[:lender])
		if request.post?
			# Create their password
#			@password = random_password
#			@password_hash = Digest::SHA1.hexdigest(@password)
#			@lender.password = @password_hash
		
			if @lender.save
				flash[:notice] = "Your application has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @lender.email + "</B></Font> with additional information."

				Emailer.deliver_lender_application("#{@lender.first_name}", "#{@lender.last_name}", "#{@lender.email}")
				Emailer.deliver_lender_application_notify("#{@lender.first_name}", "#{@lender.last_name}", "#{@lender.email}", "#{@lender.id}")
				redirect_to :controller => 'main', :action => 'index'
			end
		end
	end

	def installer
		@installer = Installer.new(params[:installer])
		if request.post?
			# Create their password
#			@password = random_password
#			@password_hash = Digest::SHA1.hexdigest(@password)
#			@installer.password = @password_hash
					
			if @installer.save

				flash[:notice] = "Your application has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @installer.email + "</B></Font> with additional information."
				Emailer.deliver_installer_application("#{@installer.company_name}", "#{@installer.first_name}", "{@installer.last_name}", "#{@installer.email}")
				Emailer.deliver_installer_application_notify("#{@installer.company_name}", "#{@installer.first_name}", "#{@installer.last_name}", "#{@installer.email}", "#{@installer.id}", "#{@installer.applicant_comments}")
	
				redirect_to :controller => 'main', :action => 'index'
			end
		end	
	end
end
