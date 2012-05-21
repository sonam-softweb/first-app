class ChangePasswordController < ApplicationController
before_filter :login_required


  def edit
  end

  def update
    @user = current_user
    if params[:old_password].blank? 
      flash[:notice] = "Please enter old password"
      redirect_to :controller => 'change_password', :action => 'edit'
    else
      if @user.valid_password?(params[:old_password])
        if params[:password].blank?
          flash[:notice] = "Please enter new password"
          redirect_to :controller => 'change_password', :action => 'edit'
        elsif params[:password].length < 4
          flash[:notice] = "Password should have minimum of 4 characters"
          redirect_to :controller => 'change_password', :action => 'edit'
        else
          @user.password = params[:password]
          @user.password_confirmation = params[:password_confirmation]
	    if @user.save
	       flash[:notice] = "Password successfully updated"
	       redirect_to :controller => 'manage', :action => 'index'
	    else
	        flash[:notice] = @user.errors.messages.first[1][0]
		redirect_to :controller => 'change_password', :action => 'edit'
	    end
         end
       end
    end
  end
end
