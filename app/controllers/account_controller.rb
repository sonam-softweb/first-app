class AccountController < ApplicationController
skip_before_filter :login_required
#layout "proposed"
  
#	def login
#		if request.post?
#			# Does e-mail address exist?
#			sql = "select user_id, 'managers' as tbl from managers where email='#{params[:email]}' UNION select user_id, 'installers' as tbl from installers where email='#{params[:email]}' UNION select user_id, 'borrowers' as tbl from borrowers where email='#{params[:email]}' UNION select user_id, 'lenders' as tbl from lenders where email='#{params[:email]}';"
#			result = User.find_by_sql(sql)[0]
#			if result.nil?
#				# email address does not exist
#				flash[:notice] = 'Login unsuccessful - email address does not exist.'
#			else
#				# email address does exist
#				@user_id = result.user_id
#				@table_name = result.tbl
#				# check password
#				@current_user = User.find_by_id_and_password(@user_id, Digest::SHA1.hexdigest(params[:password]))
#
#				unless @current_user.nil?
#					session[:user_id] = @current_user.id
#					session[:user_type] = @current_user.user_type
#					unless session[:return_to].blank?
#						redirect_to session[:return_to]
#						session[:return_to] = nil
#					else
#						redirect_to :controller => 'manage', :action => 'index' if session[:user_type] == "manager"
#						redirect_to :controller => 'installer', :action => 'index' if session[:user_type] == "installer"
#						redirect_to :controller => 'borrower', :action => 'index' if session[:user_type] == "borrower"
#						redirect_to :controller => 'lender', :action => 'index' if session[:user_type] == "lender"
#					end
#				else
#					flash[:notice] = 'Login unsuccessful - incorrect password.'
#				end
#
#
#			end
#		end
#	end

  def login
    if request.post?
      #@current_user = User.find_by_email_and_password(params[:email], Digest::SHA1.hexdigest(params[:password]))
      @current_user = User.find_by_email_and_password(params[:email], params[:password])
      unless @current_user.nil?
        session[:user_id] = @current_user.id
        flash[:notice] = 'Login Successful'
        unless session[:return_to].blank?
          redirect_to session[:return_to]
          session[:return_to] = nil
        else
          redirect_to :controller => 'main', :action => 'index'
        end
      else
        flash[:notice] = 'Login unsuccessful'
      end
    end
  end
  
  def logout
    session[:user_id] = @current_user = nil
    session[:return_to] = nil
    session[:current_user_borrower_id] = nil
    session[:current_user_lender_id] = nil
    session[:current_user_installer_id] = nil
    session[:current_user_manager_id] = nil
    flash[:notice] = 'Logout Successful'          
    redirect_to '/account/login'
  end
end
