# Preview all emails at http://localhost:3000/rails/mailers/bug_mailer

class BugMailerPreview < ActionMailer::Preview
	def report
		BugMailer.report(
			"test@test.com", 
			"test email content", 
			"test email"
		)
	end
end
