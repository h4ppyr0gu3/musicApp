class BugMailer < ApplicationMailer
	default from: "#{ENV['MAILER_EMAIL']}"

	def report(email, subject="Reporter", message)
		@email = email
		@message = message
		@subject = subject
		
		mail(
			to: ENV['CONTACT_EMAIL'],
			subject: "Report mailer"
		) 
	end

	def contact(email, subject="Contact", message)
		@email = email
		@message = message
		@subject = subject
		
		mail(
			to: ENV['CONTACT_EMAIL'],
			subject: "Contact mailer"
		) 
	end
end
