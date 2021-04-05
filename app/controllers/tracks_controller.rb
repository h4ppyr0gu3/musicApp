class TracksController < ApplicationController

	before_action :authenticate_user!

	def index
		@all_tracks = Track.where(
			user_id: current_user.id
		).page params[:page]
	end

	def destroy
		Track.(user_id: current_user.id, song_id: params[:id])[0].destroy
		redirect_to track_path
	end

end