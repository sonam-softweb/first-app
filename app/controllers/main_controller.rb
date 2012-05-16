class MainController < ApplicationController

before_filter :login_required

	def index
		if @user_borrowers && !@user_borrowers.empty?
			# this user includes at least one borrower.  make sure any changes here are copied to borrower_controller.rb
			@borrower = Borrower.find(session[:current_user_borrower_id])
			@bids =  @borrower.bids.sum("amount") || 0
		end
	end

	def switch_installer
		session[:current_user_installer_id] = params[:id]
		redirect_to :back
	end


	def installers
		@installers = Installer.find(:all)
	end

	def installer_details
		@installer = Installer.find(params[:id])
		@borrowers = Borrower.find(:all, :conditions => "status = 'Displayed' AND installer_id = " + params[:id])


	end

end
