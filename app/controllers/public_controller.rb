class PublicController < ApplicationController
  skip_before_filter :login_required
#  layout "proposed"

#  def index2
#    @EmailList = EmailList.find(2)
#
#    @EmailSubscriber = EmailSubscriber.new(params[:email_subscriber])
#    if request.post?
#      if params[:notspam].upcase == "CollectiveSun".upcase
#        if @EmailSubscriber.save
#          flash[:notice] = "Your request has been saved.  The e-mail address <B><Font Color=Red>" + @EmailSubscriber.email + "</B></Font> has been added to the e-mail list."
#
#          Emailer.deliver_email_subscriber("#{@EmailSubscriber.first_name}", "#{@EmailSubscriber.id}", "#{@EmailList.id}", "#{@EmailSubscriber.email}")
#          Emailer.deliver_email_subscriber_notify("#{@EmailSubscriber.first_name}", "#{@EmailSubscriber.last_name}", "#{@EmailSubscriber.email}", "#{@EmailSubscriber.id}", "#{@EmailList.id}")
#          redirect_to :controller => 'main', :action => 'index'
#        end
#      else
#        flash[:notice] = "<Font Color=Red>Your request was <b>not</b> saved because you incorrectly entered '<B>CollectiveSun</B>' in the anti-spam feature.</Font>"
#      end
#    end
#    render :layout => false
#  end

#  def index_new
#    @borrowers = Borrower.find(:all, :conditions => ["status  = ? and expiration_date >= ?", "Displayed", DateTime.now])
#  end


  def index
    @borrowers = Borrower.find(:all, :conditions => ["status  = ? and expiration_date >= ?", "Displayed", DateTime.now])

    #@borrowers = Borrower.find(:all, :conditions => {"status" => "Displayed"})

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

  end

	def show
		@borrower = Borrower.find(params[:id])
          @photos = @borrower.photos
		@total_bids =  @borrower.bids.sum("amount") || 0
		@bids = @borrower.bids
	end

	def about

	end

	def contact

	end

	def lenders

	end

	def borrowers

	end

	def installers

	end

	def faq
	end

        def benefactor
	end

        def nonprofit
	end

        def how_its_work
	end

        def use_case
	end

end
