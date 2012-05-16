# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log

	before_filter :fetch_logged_in_user
#	before_filter :login_required

	protected
	def fetch_logged_in_user
		return if session[:user_id].blank?
		current_user = User.find_by_id(session[:user_id])

#		session[:borrower_user] = false
#		session[:lender_user] = false
#		session[:installer_user] = false
#		session[:manager_user] = false
		@user_borrowers = Array.new
		@user_lenders = Array.new
		@user_installers = Array.new
		@user_managers = Array.new

		current_user.user_rights.each do |x|
			if ! x.borrower_id.nil?
#				session[:borrower_user] = true
				@user_borrowers << x.borrower_id
				session[:current_user_borrower_id] = x.borrower_id if session[:current_user_borrower_id].nil? == true

			end
			if ! x.lender_id.nil?
#				session[:lender_user] = true
				@user_lenders << x.lender_id
				session[:current_user_lender_id] = x.lender_id if session[:current_user_lender_id].nil? == true
			end
			if ! x.installer_id.nil?
#				session[:installer_user] = true
				@user_installers << x.installer_id
				session[:current_user_installer_id] = x.installer_id if session[:current_user_installer_id].nil? == true
			end
			if ! x.manager_id.nil?
#				session[:manager_user] = true
				@user_managers << x.manager_id
				session[:current_user_manager_id] = x.manager_id if session[:current_user_manager_id].nil? == true
			end
		end


#		current_user2 = current_user.manager if session[:user_type] == "manager"
#		current_user2 = current_user.installer if session[:user_type] == "installer"
#		current_user2 = current_user.borrower if session[:user_type] == "borrower"
#		current_user2 = current_user.lender if session[:user_type] == "lender"
	end

	def logged_in?
		!current_user.blank?
	end
	helper_method :logged_in?

	def login_required
		return true if logged_in?
		session[:return_to] = request.request_uri
#		redirect_to :controller => "/account", :action => "login" and return false
#		session[:temp_amount] = params[:amount]
		redirect_to :controller => "account", :action => "login" and return false
	end

	def manager_required
#		return true if session[:manager_user] == true
		return true if @user_managers.empty? == false
		session[:return_to] = request.request_uri
#		flash[:notice] = "Sorry, you are not an administrator."
		flash[:notice] = "Sorry, you are not authorized to view this page."
		redirect_to :controller => "account", :action => "login" and return false
	end

	def installer_required
#		return true if session[:installer_user] == true
		return true if @user_installers.empty? == false
		session[:return_to] = request.request_uri
#		flash[:notice] = "Sorry, you are not an installer."
		flash[:notice] = "Sorry, you are not authorized to view this page."
		redirect_to :controller => "account", :action => "login" and return false
	end

	def lender_required
#		return true if session[:user_type] == "lender"
		return true if @user_lenders.empty? == false
		session[:return_to] = request.request_uri
#		flash[:notice] = "Sorry, you are not a lender."
		flash[:notice] = "Sorry, you are not authorized to view this page."
		session[:temp_amount] = params[:amount]
		redirect_to :controller => "account", :action => "login" and return false
	end

	def borrower_required
#		return true if session[:user_type] == "borrower"
		return true if @user_borrowers.empty? == false
		session[:return_to] = request.request_uri
#		flash[:notice] = "Sorry, you are not a borrower."
		flash[:notice] = "Sorry, you are not authorized to view this page."
		redirect_to :controller => "account", :action => "login" and return false
	end

	def random_password(size = 8)
	  chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
	  (1..size).collect{|a| chars[rand(chars.size)] }.join
	end

# 	def status_displayed_required
#		return true if Borrower.find(params[:id]).status == "Displayed" || Borrower.find(params[:id]).status == "FullySubscribed" || Borrower.find(params[:id]).status == "Funded"
##		session[:return_to] = request.request_uri
#		flash[:notice] = "Sorry, that project is not available.  Please select another project, below."
#		redirect_to :controller => "main", :action => "index" and return false
#	end
private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end


end
