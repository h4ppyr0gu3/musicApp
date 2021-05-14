class PlaylistsController < ApplicationController

	def index
		@playlists = User.find(current_user.id).playlists
	end

	def show
	end

	def render
		@songs = Playlist.find(params[:id]).songs
		render json: {response: "success"}
	end

	def create
		playlist = params[:playlist]
		playlist = User.find(current_user.id).playlists.create!(name: playlist, admin_user: current_user.id)
	end

	def add_to_favourites
		playlist = User.find(current_user.id).playlists.find_or_create_by!(name: "favourites", admin_user: current_user.id)
		PlaylistsTrack.find_or_create_by!(song_id: params[:id], playlist_id: playlist.id)
		render json: {success: "created"}
	end 

	def get_playlists
		playlists = User.find(current_user.id).playlists
		response = {playlists: []}
		playlists.each do |play|
			if play.name != 'favourites' && play.name != 'tracks'
				response[:playlists].push({name: play.name, playlist_id: play.id})
			end
		end
		render json: response
	end

	def add_song
		PlaylistsTrack.find_or_create_by!(playlist_id: params[:playlist_id], song_id: params[:song_id])
		render json: {success: "created"}
	end

	def favourites
	end



end
