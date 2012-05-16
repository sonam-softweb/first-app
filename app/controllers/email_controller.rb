class EmailController < ApplicationController
	def index
	end
	
	def subscribe
		@EmailList = EmailList.find(params[:id])

		@EmailSubscriber = EmailSubscriber.new(params[:email_subscriber])
		if request.post?
			if params[:notspam].to_s.upcase == "CollectiveSun".upcase || params[:id] == "2" # (if id=2, it's a newsletter request, so skip the spam test)
				if @EmailSubscriber.save
					flash[:notice] = "Your request has been saved.  The e-mail address <B><Font Color=Red>" + @EmailSubscriber.email + "</B></Font> has been added to the e-mail list."
	
					Emailer.deliver_email_subscriber("#{@EmailSubscriber.first_name}", "#{@EmailSubscriber.id}", "#{@EmailList.id}", "#{@EmailSubscriber.email}")
					Emailer.deliver_email_subscriber_notify("#{@EmailSubscriber.first_name}", "#{@EmailSubscriber.last_name}", "#{@EmailSubscriber.email}", "#{@EmailSubscriber.id}", "#{@EmailList.id}")
					redirect_to :controller => 'public', :action => 'index'
				end
			else
				flash[:notice] = "<Font Color=Red>Your request was <b>not</b> saved because you incorrectly entered '<B>CollectiveSun</B>' in the anti-spam feature.</Font>"
			end
		end
	end
	
	def unsubscribe
	end

	def email_share_project
		@borrower = Borrower.find(params[:id])
		@email_share_project = EmailShareProject.new(params[:email_share_project])
		if request.post?
			if params[:notspam].upcase == "CollectiveSun".upcase
				if @email_share_project.save
					flash[:notice] = "An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @email_share_project.to_email + "</B></Font>."
		
					Emailer.deliver_email_share_project("#{@email_share_project.borrower_id}", "#{@email_share_project.from_name}", "#{@email_share_project.from_email}", "#{@email_share_project.to_name}", "#{@email_share_project.to_email}", "#{@email_share_project.message}")
		
					redirect_to :controller => 'borrower', :action => 'show', :id => params[:id]
				
				end
			else
				flash[:notice] = "<Font Color=Red>Your request was <b>not</b> saved because you incorrectly entered '<B>CollectiveSun</B>' in the anti-spam feature.</Font>"
			
			end	
		end
	end



end
