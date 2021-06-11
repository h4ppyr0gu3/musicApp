class Friends::PlaylistsController < ApplicationController

	def index 
		
	end

	def show
		@q = User.where(id: current_user.friendships.confirmed.pluck(:friend_id)).ransack(params[:q])
  	@users = @q.result(distinct: true)
	end

	def update
		User.find(params[:user]).playlists << Playlist.find(params[:id])
	end

end