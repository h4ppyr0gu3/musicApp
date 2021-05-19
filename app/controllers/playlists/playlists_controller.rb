class Playlists::PlaylistsController < ApplicationController
  def index
  	@playlists = User.find(current_user.id).playlists
	end
	
  def show
  	@playlists = User.find(current_user.id).playlists
  end
end