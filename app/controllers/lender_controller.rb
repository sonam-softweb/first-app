class LenderController < ApplicationController

before_filter :login_required, :except => "lender_registration"
#before_filter :lender_required,  # You must have a user_right of "Lender"

	def index

	end

	def invest
		if ! session[:temp_amount].blank?
			@amount = session[:temp_amount]
			session[:temp_amount] = nil
		else
			@amount = params[:amount].to_s.to_i
			# the .to_s.to_i is done to avoid this error: NoMethodError (undefined method `to_i' for ["5"]:Array):
		end

		@borrower = Borrower.find(params[:id])
		@bids = @borrower.bids.sum("amount").to_i
		@still_needed = @borrower.system_price.to_i - @bids
		if @amount.to_s.to_i > @still_needed.to_i
		# What if the lender is bidding more than the amount still needed?  Reduce it to just the amount still needed.
			@amount = @still_needed
			flash[:notice] = "Your bid was adjusted down to match the maximum amount still needed to fund this project."
		end


		@bid = Bid.new(params[:bid])
		@bid.lender_id = session[:current_user_lender_id]
		@bid.borrower_id = @borrower.id
		if params[:bid] and @bid.save
			# Did this bid result in 100% of the project being funded?
			if @borrower.bids.sum("amount").to_i == @borrower.system_price.to_i
				# Update record
				@borrower.update_attribute(:status, "FullySubscribed")
				Emailer.deliver_borrower_goal_reached_notify("#{@borrower.id}", "#{@borrower.system_price}")

			end
			flash[:notice] = "Your bid of $#{@bid.amount} has been saved.  An <B>e-mail</B> confirmation has been sent to <B><Font Color=Red>" + current_user.email + "</B></Font>."

			Emailer.deliver_lender_bid("#{params[:id]}", "#{current_user.first_name}", "#{current_user.email}", "#{@bid.amount}", "#{@borrower.zip}")
			Emailer.deliver_lender_bid_notify("#{current_user.id}", "#{current_user.first_name}", "#{current_user.last_name}", "#{current_user.email}", "#{@bid.amount}", "#{@bid.id}")
			redirect_to :controller => 'public', :action => 'show', :id => @borrower.id

		end
	end


	def bid_history
		@lender = Lender.find(session[:current_user_lender_id])
		@bids =  @lender.bids
	end

	def loan_history
		@lender = Lender.find(session[:current_user_lender_id]).loans
		@loans =  Loan.find(:all, :conditions => {:lender_id => session[:current_user_lender_id]})
	end


  def lender_registration
    if request.post?
			@lender = Lender.new(params[:lender])
#			@user = User.new

			# Record this lender's ID in the lenderlender record
			#@lender.installer_id = session[:current_user_installer_id]

			# Create the password for the URL
			#password = @lender.email.to_s + "secret" + @lender.installer_id.to_s
			#@password_hash = Digest::SHA1.hexdigest(password)

			# Create their password
#			password = random_password
#			@password_hash = Digest::SHA1.hexdigest(password)
#			@user.password = @password_hash
#			@user.borrower_id = @borrower_application.id
#			@user.user_type = "lenderlender"

#			if @lenderlender.save && @user.save && @lenderlender.update_attribute(:user_id, @user.id)
			if @lender.save
        flash[:notice] = "Your application has been received.  An <B>e-mail</B> has been sent to <B><Font Color=Red>" + @lender.email + "</B></Font> with additional information."

				Emailer.deliver_lender_application("#{@lender.first_name}", "#{@lender.last_name}", "#{@lender.email}")
				Emailer.deliver_lender_application_notify("#{@lender.first_name}", "#{@lender.last_name}", "#{@lender.email}", "#{@lender.id}")
				redirect_to :controller => 'main', :action => 'index'
			end
		end
	end

end
