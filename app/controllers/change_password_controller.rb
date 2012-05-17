class ChangePasswordController < ApplicationController

  def edit
  end

  def update
    @user = current_user
    @user.password = params[:new_password]
    @user.password_confirmation = params[:confirm_password]
    if @user.valid_password?(params[:old_password]) && @user.save  
      flash[:notice] = "Password successfully updated"  
      redirect_to :controller => 'manage', :action => 'index'
    else  
      render :action => :edit  
    end  
  end
end
