class ProfileController < ApplicationController
	before_action :set_user, only: %w[ update add info ]
	
	def index
		@user = User.first
	end

	def add
		@user = current_user
	end

	def update
		puts user_params
		if @user.update(user_params)
			redr = profile_index_path
			flash = { success: "Success" } 
		else
			redr = add_path
			flash = { error: "Can't update, pls check fields" }
		end
		redirect_to redr, flash: flash
	end

	def settings
	end

	private

	def user_params
		params.require(:user).permit(
			:first_name,
			:last_name,
			:image
		)
	end

	def set_user
		@user ||= current_user
	end
end
