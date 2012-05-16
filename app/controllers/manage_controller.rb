class ManageController < ApplicationController
before_filter :login_required
before_filter :manager_required # You must have a user_right of "manager"

	def index
	end

## INSTALLER APPLICATIONS ##

	def list_installers
#		@installers = Installer.find(:all)
		@installers = Installer.find(:all, :conditions => {"status" => "Approved"})
	end

	def list_installer_applications
#		@installer_applications = InstallerApplication.find(:all, :conditions => ["status <> ? OR status IS NULL", "Denied"])
#		@installer_applications = InstallerApplication.find(:all, :conditions => ["status IS NULL"])
		@installer_applications = Installer.find(:all, :conditions => {"status" => "Under Review"})
	end

	def edit_installer_application
		@installer_application = Installer.find(params[:id])

		if request.post? and @installer_application.update_attributes(params[:installer_application])
			flash[:notice] = "Record for #{@installer_application.company_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end

	def approve_installer_application
		# Update status, user_id fields in application + add user record
		@installer_application = Installer.find(params[:id])

		@user = User.new
		# Create their password
		@password = random_password
		@password_hash = Digest::SHA1.hexdigest(@password)
		@user.password = @password_hash
		@user.installer_id = @installer_application.id
		@user.user_type = "installer"

		if @user.save && @installer_application.update_attribute(:status, "Approved") && @installer_application.update_attribute(:user_id, @user.id)
			# Create client in Payments Gateway
			account = PaymentsGateway::MerchantAccount.new('138148', '3P0Uvj4a8V', 'B0v6xPbI3', 'n68V8A4jNXu', false)
			client = PaymentsGateway::Client.new
			client.first_name = @installer_application.first_name
			client.last_name = @installer_application.last_name
			client.company_name = @installer_application.company_name
			client.address1 = @installer_application.street_address
			client.email_address = @installer_application.email
			client.city = @installer_application.city
			client.state = @installer_application.state
			client.postal_code = @installer_application.zip
			client.phone_number = @installer_application.phone
			client.fax_number = @installer_application.fax
			client.consumer_id = @user.id

			client_id = account.create_client(client)
			@installer_application.update_attribute(:client_id_pg, client_id)


			# Send e-mail to installer with approval notice
			Emailer.deliver_installer_application_approve("#{@installer_application.company_name}", "#{@installer_application.first_name}", "#{@installer_application.email}", @password)
			Emailer.deliver_installer_application_approve_notify("#{@installer_application.company_name}", "#{@installer_application.first_name}", "#{@installer_application.last_name}", "#{@installer_application.email}", "#{@installer_application.id}", "#{@installer_application.applicant_comments}", "#{@installer_application.our_notes}")

			flash[:notice] = "Approved Application for #{@installer_application.company_name}"
			redirect_to :controller => "manage"


		end


#		# Update status field in application, copy record to installer table and create user.
#		@installer_application = InstallerApplication.find(params[:id])
#		@password = random_password
#		@password_hash = Digest::SHA1.hexdigest(@password)
#
#		if @installer_application.update_attribute(:status, "Approved") and @new_installer_record = Installer.create({:company_name => @installer_application.company_name, :first_name => @installer_application.first_name, :last_name => @installer_application.last_name, :email => @installer_application.email, :street_address => @installer_application.street_address, :city => @installer_application.city, :state => @installer_application.state, :zip => @installer_application.zip, :phone => @installer_application.phone, :our_notes => @installer_application.our_notes, :latitude => @installer_application.latitude, :longitude => @installer_application.longitude, :installer_application_id => @installer_application.id }) and @new_user_record = User.create({:email => @installer_application.email, :password => @password_hash, :first_name => @installer_application.first_name, :last_name => @installer_application.last_name, :user_type => "Installer", :installer_id => @new_installer_record.id})
###		if @installer_application.update_attribute(:status, "Approved") and Installer.create(@installer_application.attributes)
#			# Send e-mail to installer with approval notice and new user information
#			Emailer.deliver_new_installer_application_approve("#{@new_installer_record.company_name}", "#{@new_installer_record.first_name}", @password, "#{@new_installer_record.email}")
#			Emailer.deliver_new_installer_application_approve_notify("#{@new_installer_record.company_name}", "#{@new_installer_record.first_name}", "#{@new_installer_record.last_name}", "#{@new_installer_record.email}", "#{@new_installer_record.id}", "#{@installer_application.applicant_comments}", "#{@new_installer_record.our_notes}")
#
#			flash[:notice] = "Approved Application for #{@installer_application.company_name}"
#			redirect_to :controller => "manage"
#		end

	end

	def deny_installer_application
		@installer_application = Installer.find(params[:id])
		if @installer_application.update_attribute(:status, "Denied")
			# Send e-mail to installer with deny notice
			Emailer.deliver_installer_application_deny("#{@installer_application.company_name}", "#{@installer_application.first_name}", "#{@installer_application.email}")
			Emailer.deliver_installer_application_deny_notify("#{@installer_application.company_name}", "#{@installer_application.first_name}", "#{@installer_application.last_name}", "#{@installer_application.email}", "#{@installer_application.id}", "#{@installer_application.applicant_comments}", "#{@installer_application.our_notes}")

			flash[:notice] = "Denied Application for #{@installer_application.company_name}"
			redirect_to :controller => "manage"
		end
	end

	def edit_installer
		@installer = Installer.find(params[:id])

		if request.post? and @installer.update_attributes(params[:installer])
			flash[:notice] = "Record for #{@installer.company_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end


## BORROWER APPLICATIONS ##

	def list_borrowers
#		@borrowers = Borrower.find(:all)
#		@borrowers = Borrower.find(:all, :conditions => {"status" => "Approved"})
#		@borrowers = Borrower.find(:all, :conditions => ["status = ? or status = ?", "Approved", "Displayed"])
#		@borrowers = Borrower.find(:all, :conditions => {:status => ["Approved", "Displayed", "FullySubscribed"]})
		@borrowers = Borrower.find(:all, :conditions => {:status => ["Approved", "Displayed"]})

		@funded_borrowers = Borrower.find(:all, :conditions => ["status = ?", "Funded"])

	end

	def list_borrower_applications
#		@borrower_applications = BorrowerApplication.find(:all, :conditions => ["status IS NULL"])
#		@borrower_applications = Borrower.find(:all, :conditions => {:status => "Under Review"})
		@borrower_applications = Borrower.find(:all, :conditions => {:status => ["SubmittedByInstaller", "Under Review"]})

	end

	def edit_borrower_application
		@borrower_application = Borrower.find(params[:id])

		if request.post? and @borrower_application.update_attributes(params[:borrower_application])
			flash[:notice] = "Record for #{@borrower_application.first_name} #{@borrower_application.last_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end

	def approve_borrower_application
		# Update status, user_id, system price, approval_date, expiration_date fields in application + add user record
		@borrower_application = Borrower.find(params[:id])
		@user = User.new
		# Create their password
		@password = random_password
		@password_hash = Digest::SHA1.hexdigest(@password)
		@user.password = @password_hash
		@user.borrower_id = @borrower_application.id
		@user.user_type = "borrower"

		if @user.save && @borrower_application.update_attribute(:status, "Approved") && @borrower_application.update_attribute(:user_id, @user.id) && @borrower_application.update_attribute(:system_price, @borrower_application.system_price.to_i + 495) && @borrower_application.update_attribute(:approval_date, Time.now()) && @borrower_application.update_attribute(:expiration_date, Time.now().advance(:days =>21))

			# Send e-mail to borrower with approval notice
			Emailer.deliver_borrower_application_approve("#{@borrower_application.first_name}", "#{@borrower_application.email}", @password)
			Emailer.deliver_borrower_application_approve_notify("#{@borrower_application.first_name}", "#{@borrower_application.last_name}", "#{@borrower_application.email}", "#{@borrower_application.id}", "#{@borrower_application.our_notes}")

			flash[:notice] = "Approved Application for #{@borrower_application.first_name} #{@borrower_application.last_name}"
			redirect_to :controller => "manage"
		end


#		# Update status field in application, copy record to project owner table and create user.
#		@project_owner_application = ProjectOwnerApplication.find(params[:id])
#		@password = random_password
#		@password_hash = Digest::SHA1.hexdigest(random_password)
#
#		if @project_owner_application.update_attribute(:status, "Approved") and @new_project_owner_record = ProjectOwner.create({:first_name => @project_owner_application.first_name, :last_name => @project_owner_application.last_name, :email => @project_owner_application.email, :street_address => @project_owner_application.street_address, :city => @project_owner_application.city, :state => @project_owner_application.state, :zip => @project_owner_application.zip, :phone => @project_owner_application.phone, :our_notes => @project_owner_application.our_notes, :latitude => @project_owner_application.latitude, :longitude => @project_owner_application.longitude, :project_owner_application_id => @project_owner_application.id }) and @new_user_record = User.create({:email => @project_owner_application.email, :password => @password_hash, :first_name => @project_owner_application.first_name, :last_name => @project_owner_application.last_name, :user_type => "Project Owner", :project_owner_id => @new_project_owner_record.id})
###		if @installer_application.update_attribute(:status, "Approved") and Installer.create(@installer_application.attributes)
#			# Send e-mail to installer with approval notice and new user information
#			Emailer.deliver_new_project_owner_application_approve("#{@new_project_owner_record.first_name}", @password, "#{@new_project_owner_record.email}")
#			Emailer.deliver_new_project_owner_application_approve_notify("#{@new_project_owner_record.first_name}", "#{@new_project_owner_record.last_name}", "#{@new_project_owner_record.email}", "#{@new_project_owner_record.id}", "#{@new_project_owner_record.our_notes}")
#
#			flash[:notice] = "Approved Application for #{@project_owner_application.first_name} #{@project_owner_application.last_name}"
#			redirect_to :controller => "manage"
#		end

	end

	def deny_borrower_application
		@borrower_application = Borrower.find(params[:id])
		if @borrower_application.update_attribute(:status, "Denied")
			# Send e-mail to borrower with deny notice
			Emailer.deliver_borrower_application_deny("#{@borrower_application.first_name}", "#{@borrower_application.email}")
			Emailer.deliver_borrower_application_deny_notify("#{@borrower_application.first_name}", "#{@borrower_application.last_name}", "#{@borrower_application.email}", "#{@borrower_application.id}", "#{@borrower_application.our_notes}")

			flash[:notice] = "Denied Application for #{@borrower_application.first_name} #{@borrower_application.last_name}"
			redirect_to :controller => "manage"
		end
	end

	def edit_borrower
		@borrower = Borrower.find(params[:id])

		if request.post? and @borrower.update_attributes(params[:borrower])
			flash[:notice] = "Record for #{@borrower.first_name} #{@borrower.last_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end

	def list_fully_subscribed
		@borrowers = Borrower.find(:all, :conditions => {:status => ["FullySubscribed"]})
	end

	def edit_fully_subscribed
		@borrower = Borrower.find(params[:id])
		if request.post? and @borrower.update_attributes(params[:borrower])
			flash[:notice] = "Record for #{@borrower.first_name} #{@borrower.last_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end

	def approve_fully_subscribed
		# Setup Loan Table with percentages for each Lender
		@borrower = Borrower.find(params[:id])
		@total_bids = Bid.find(:all, :select => 'lender_id, borrower_id, sum(amount) as amount', :group=>'lender_id', :conditions => ['borrower_id = ?', params[:id]])
		@total_bids.each do |x|
			y = Loan.create(:borrower_id => params[:id], :lender_id => x.lender_id, :lender_percentage => (x.amount.to_f / @borrower.system_price.to_f), :start_date => Date.today.advance(:months =>1), :end_date => Date.today.advance(:months => 120))
			#go back to each of the bids and update them with the loan_id that they contributed to/created
			@individual_user_bids = Bid.find_all_by_lender_id_and_borrower_id(x.lender_id, params[:id])
			@individual_user_bids.each do |z|
				z.update_attribute(:loan_id, y.id)
			end
		end

		# Calculate Monthly Payment
		principal = @borrower.system_price.to_f
		rate = 0.06/12
		number_of_periods = 120
		numerator = rate * ((1 + rate) ** number_of_periods)
		denominator = ((1 + rate) ** number_of_periods ) - 1
		payment = principal * ( numerator / denominator )


		# set up due_borrower_payments
		1.upto(120) {|x| DueBorrowerPayment.create(:borrower_id => params[:id], :due_amount => payment, :due_date => Date.today.advance(:months => x) ) }

		# Update status, payment (in the borrower table)
		if @borrower.update_attribute(:status, "Funded") && @borrower.update_attribute(:monthly_payment, payment)

			# Send e-mail to borrower with approval notice
			Emailer.deliver_borrower_funded_approve("#{@borrower.id}", "#{@borrower.first_name}", "#{@borrower.email}")
			Emailer.deliver_borrower_funded_approve_notify("#{@borrower.id}", "#{@borrower.first_name}", "#{@borrower.last_name}", "#{@borrower.email}")

			# Send e-mails to lenders with approval notice
			@total_bids.each do |x|
				Emailer.deliver_lender_funded_approve("#{x.lender.id}", "#{x.borrower.id}", "#{x.lender.first_name}", "#{x.lender.email}", "#{x.amount}" )


			end

	#		Emailer.deliver_borrower_application_approve_notify("#{@borrower_application.first_name}", "#{@borrower_application.last_name}", "#{@borrower_application.email}", "#{@borrower_application.id}", "#{@borrower_application.our_notes}")


			flash[:notice] = "Funding has been processed for #{@borrower.first_name} #{@borrower.last_name}."
			redirect_to :controller => "manage"
		end

	end


## LENDER APPLICATIONS ##

	def list_lenders
		@lenders = Lender.find(:all, :conditions => {"status" => "Approved"})
	end

	def list_lender_applications
		@lender_applications = Lender.find(:all, :conditions => {"status" => "Under Review"})
	end

	def edit_lender_application
		@lender_application = Lender.find(params[:id])

		if request.post? and @lender_application.update_attributes(params[:lender_application])
			flash[:notice] = "Record for #{@lender_application.first_name} #{@lender_application.last_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end

	def approve_lender_application
		# Update status, user_id fields in application + add user record
		@lender_application = Lender.find(params[:id])
		@user = User.new
		# Create their password
		@password = random_password
		@password_hash = Digest::SHA1.hexdigest(@password)
		@user.password = @password
		@user.email = @lender_application.email
		@user.password_confirmation = @password

		#@user.email = @lender_application.email
		#@user.lender_id = @lender_application.id
		#@user.user_type = "lender"

		if @user.save! && @lender_application.update_attribute(:status, "Approved") && @lender_application.update_attribute(:user_id, @user.id)
			UserRight.create :user_id => @user.id, :lender_id => @lender_application.id
			# Send e-mail to lender with approval notice
			Emailer.deliver_lender_application_approve("#{@lender_application.first_name}", "#{@lender_application.email}", @password)
			Emailer.deliver_lender_application_approve_notify("#{@lender_application.first_name}", "#{@lender_application.last_name}", "#{@lender_application.email}", "#{@lender_application.id}", "#{@lender_application.our_notes}")

			flash[:notice] = "Approved Application for #{@lender_application.first_name} #{@lender_application.last_name}"
			redirect_to :controller => "manage"
		end
	end

	def deny_lender_application
		@lender_application = Lender.find(params[:id])
		if @lender_application.update_attribute(:status, "Denied")
			# Send e-mail to lender with deny notice
			Emailer.deliver_lender_application_deny("#{@lender_application.first_name}", "#{@lender_application.email}")
			Emailer.deliver_lender_application_deny_notify("#{@lender_application.first_name}", "#{@lender_application.last_name}", "#{@lender_application.email}", "#{@lender_application.id}", "#{@lender_application.our_notes}")

			flash[:notice] = "Denied Application for #{@lender_application.first_name} #{@lender_application.last_name}"
			redirect_to :controller => "manage"
		end
	end

	def edit_lender
		@lender = Lender.find(params[:id])

		if request.post? and @lender.update_attributes(params[:lender])
			flash[:notice] = "Record for #{@lender.first_name} #{@lender.last_name} Updated!"
			redirect_to :controller => 'manage', :action => 'index'
		end
	end


## OTHER ##

	def list_pending_borrower_payments
		@pending_borrower_payments = DueBorrowerPayment.find(:all, :conditions => "due_date <= '" + Date.today.to_s + "' AND processed = 0")
#		@text = ""
		@text = String.new
		if request.post? && params[:due_borrower_payments]
			params[:due_borrower_payments].each do |x|
				@text = @text + x.to_s
			flash[:notice] = x
			end

			flash[:notice] = "Posted! #{@text}"

		end

	end


end
