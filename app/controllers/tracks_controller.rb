class TracksController < ApplicationController

	before_action :authenticate_user!

	def index
		@all_tracks = Track.where(
			user_id: current_user.id
		).page params[:page]
	end

	def destroy
		Track.find(params[:id]).destroy
		redirect_to tracks_path
	end

end