class Emailer < ActionMailer::Base

## INSTALLER E-MAILS ##

	def installer_application(company_name, first_name, last_name, recipient)
		subject "Collective Sun Installer Application Received"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		body[:last_name] = last_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def installer_application_notify(company_name, first_name, last_name, email, id, applicant_comments)
		subject "Collective Sun Installer Application Received"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:applicant_comments] = applicant_comments
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def installer_application_approve(company_name, first_name, recipient, password)
		subject "Collective Sun Installer Application Approved"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		body[:password] = password
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def installer_application_approve_notify(company_name, first_name, last_name, email, id, applicant_comments, our_notes)
		subject "Collective Sun Installer Application Approved"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:applicant_comments] = applicant_comments
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def installer_application_deny(company_name, first_name, recipient)
		subject "Collective Sun Installer Application"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def installer_application_deny_notify(company_name, first_name, last_name, email, id, applicant_comments, our_notes)
		subject "Collective Sun Installer Application Denied"
	    body[:company_name] = company_name
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:applicant_comments] = applicant_comments
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	#def borrower_submitted_by_installer_application(first_name, last_name, recipient, borrower_id, installer_id, password_hash)
	# 	subject "Collective Sun Borrower Application Received"
 #   	body[:first_name] = first_name
	# 	body[:last_name] = last_name
	# 	body[:borrower_id] = borrower_id
	# 	body[:installer_id] = installer_id
	# 	body[:company_name] = Installer.find(installer_id).company_name
	# 	body[:password_hash] = password_hash
	# 	recipients recipient
	# 	from "info@collectivesun.com"
	# 	sent_on= Time.now
	# end
	def borrower_submitted_by_installer_application(name, recipient, installer_id)
		subject "Collective Sun Borrower Application Received"
		body[:name] = name
		body[:installer_id] = installer_id
		body[:company_name] = Installer.find(installer_id).company_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_submitted_by_installer_application_notify(first_name, last_name, email, borrower_id, installer_id)
		subject "Collective Sun Borrower Application Received"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:borrower_id] = borrower_id
		body[:installer_id] = installer_id
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end


## BORROWER E-MAILS ##

	def borrower_application(first_name, last_name, recipient)
		subject "Collective Sun Borrower Application Received"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_application_notify(first_name, last_name, email, id)
		subject "Collective Sun Borrower Application Received"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_application_approve(first_name, recipient, password)
		subject "Collective Sun Application Approved"
    	body[:first_name] = first_name
		body[:password] = password
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_application_approve_notify(first_name, last_name, email, id, our_notes)
		subject "Collective Sun Borrower Application Approved"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_application_deny(first_name, recipient)
		subject "Collective Sun Application"
    	body[:first_name] = first_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_application_deny_notify(first_name, last_name, email, id, our_notes)
		subject "Collective Sun Borrower Application Denied"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_funded_approve(borrower_id, first_name, recipient)
		subject "Collective Sun Application Funded"
		body[:borrower_id] = borrower_id
    	body[:first_name] = first_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_funded_approve_notify(borrower_id, first_name, last_name, email)
		subject "Collective Sun Borrower Application Funded"
		body[:borrower_id] = borrower_id
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def borrower_goal_reached_notify(borrower_id, system_price)
		subject "Collective Sun Borrower Goal Reached"
		body[:borrower_id] = borrower_id
    	body[:system_price] = system_price
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end


## LENDER E-MAILS ##

	def lender_application(first_name, last_name, recipient)
		subject "Collective Sun Lender Application Received"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_application_notify(first_name, last_name, email, id)
		subject "Collective Sun Lender Application Received"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_application_approve(first_name, recipient, password)
		subject "Collective Sun Application Approved"
    	body[:first_name] = first_name
		body[:password] = password
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_application_approve_notify(first_name, last_name, email, id, our_notes)
		subject "Collective Sun Lender Application Approved"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_application_deny(first_name, recipient)
		subject "Collective Sun Application"
    	body[:first_name] = first_name
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_application_deny_notify(first_name, last_name, email, id, our_notes)
		subject "Collective Sun Lender Application Denied"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:id] = id
		body[:our_notes] = our_notes
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_bid(borrower_id, first_name, email, amount, zip)
		subject "Collective Sun Lender Bid"
		body[:borrower_id] = borrower_id
    	body[:first_name] = first_name
		body[:amount] = amount
		body[:zip] = zip
		recipients email
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_bid_notify(lender_id, first_name, last_name, email, amount, bid_id)
		subject "Collective Sun Lender Bid"
    	body[:lender_id] = lender_id
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:amount] = amount
		body[:bid_id] = bid_id
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def lender_funded_approve(lender_id, borrower_id, first_name, recipient, total_invested)
		subject "Collective Sun Application Funded"
		body[:lender_id] = lender_id
		body[:borrower_id] = borrower_id
    	body[:first_name] = first_name
		body[:total_invested] = total_invested
		body[:headline] = Borrower.find(borrower_id).headline
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end


## EMAIL LIST E-MAILS ##

	def email_subscriber(first_name, email_subscriber_id, email_list_id, recipient)
		subject "Collective Sun Email List Confirmation"
    	body[:first_name] = first_name
		body[:email_subscriber_id] = email_subscriber_id
		body[:email_list_id] = email_list_id
		recipients recipient
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def email_subscriber_notify(first_name, last_name, email, email_subscriber_id, email_list_id)
		subject "Collective Sun Email List Confirmation Notification"
    	body[:first_name] = first_name
		body[:last_name] = last_name
		body[:email] = email
		body[:email_subscriber_id] = email_subscriber_id
		body[:email_list_id] = email_list_id
		recipients "esha.desai@softwebsolutions.com"
		from "info@collectivesun.com"
		sent_on= Time.now
	end

	def email_share_project(borrower_id, from_name, from_email, to_name, recipient, message)
		subject "Collective Sun"
    	body[:borrower_id] = borrower_id
		body[:from_name] = from_name
		body[:from_email] = from_email
		body[:to_name] = to_name
		body[:message] = message
		recipients to_name + " <" + recipient + ">"
		from from_name + " <" + from_email + ">"
#		recipients recipient
#		from from_email

		sent_on= Time.now
	end

   def password_reset_instructions(user)
    subject      "Password Reset Instructions"
    from         "noreplay@domain.com"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_path(user.password_reset_token)
  end

end
