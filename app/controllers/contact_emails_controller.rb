class ContactEmailsController < ApplicationController
	def create
		BugMailer.contact(
			params[:email], 
			params[:subject], 
			params[:message]
		).deliver_later

		redirect_to contact_path, flash: { success: "Message sent!" }
	end
end
