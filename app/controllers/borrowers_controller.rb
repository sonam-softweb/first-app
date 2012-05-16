class BorrowersController < ApplicationController
before_filter :login_required
before_filter :borrower_required # You must have a user_right of "Borrower"
#before_filter :status_displayed_required, :only => :show

#	def show
#		@borrower = Borrower.find(params[:id])
#
#		#What kind of user is this?
#		unless current_user.blank?
#			case current_user.user_type
#				when "manager"
#					@first_name = current_user.manager.first_name
#					@last_name = current_user.manager.last_name
#				when "installer"
#					@first_name = current_user.installer.first_name
#					@last_name = current_user.installer.last_name
#				when "borrower"
#					@first_name = current_user.borrower.first_name
#					@last_name = current_user.borrower.last_name
#				when "lender"
#					@first_name = current_user.lender.first_name
#					@last_name = current_user.lender.last_name
#			end
#		end
#		@total_bids =  @borrower.bids.sum("amount") || 0
#		@bids = @borrower.bids
#	end

  def index
    # make sure any changes here are copied to the menu controller
    @borrower = Borrower.find(session[:current_user_borrower_id])
    @bids =  @borrower.bids.sum("amount") || 0
  end
  def edit
    @borrower = Borrower.find(session[:current_user_borrower_id])
    5.times {@borrower.photos.build}
    if request.post? and params[:id].to_i == session[:current_user_borrower_id] and @borrower.update_attributes(params[:borrower])
      flash[:notice] = "Record for #{@borrower.first_name} #{@borrower.last_name} Updated!"
      redirect_to :controller => 'borrower', :action => 'index'
    end

  end
  def edit_borrower
    @borrower = Borrower.find(session[:current_user_borrower_id])
    5.times {@borrower.photos.build}
    if request.post? and params[:id].to_i == session[:current_user_borrower_id] and @borrower.update_attributes(params[:borrower])
      flash[:notice] = "Record for #{@borrower.first_name} #{@borrower.last_name} Updated!"
      redirect_to :controller => 'borrower', :action => 'index'
    end

  end

  def update
    @borrower = Borrower.find(session[:current_user_borrower_id])
    respond_to do |format|
      if @borrower.update_attributes(params[:borrower])
        format.html { redirect_to borrowers_path }
      else
        format.html { render :action => "edit" }
      end
    end

  end

end
