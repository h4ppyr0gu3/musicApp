class PlaylistsController < ApplicationController

	def index
		@playlists = User.find(current_user.id).playlists
	end

	def show
		@songs = Playlist.find(params[:id]).songs
		# render json: {response: "success"}
	end

	def new
	end

	def edit
	end

	def update
	end

	def add_song
		PlaylistsTrack.find_or_create_by!(playlist_id: params[:playlist_id], song_id: params[:song_id])
		render json: {success: "created"}
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

	def favourites
		playlist = User.find(current_user.id).playlists.find_or_create_by!(name: "favourites", admin_user: current_user.id)
		@songs = playlist.songs
	end

	def tracks
	end

	def all_tracks
		@user = current_user.id
		users_tracks =  User.find(@user).playlists.where(name: 'tracks')[0].songs
		items = []
		users_tracks.each do |s|
			if s.music_file.attached? 
				array = []
				s.artists.each do |a|
					array.push(a.name)
				end 
				artists = array&.join(", ")
				entry = {}
				entry["name"] = s&.song_name
				entry["artists"] = artists
				entry["yt"] = s.yt_title
				entry["src"] = url_for(s.music_file)
				entry["img"] = s.album_art_url
				entry["status"] = s.status
				entry["id"] = s.id
				items.push(entry)
			end
		end
		response = {items: items}
		render json: response
	end

	def create_tracks
		user = current_user.id
		track =  User.find(user).playlists.where(name: 'tracks')[0].id
		PlaylistsTrack.find_or_create_by!(playlist_id: track, song_id: params[:id])
		render json: {success: "added to tracks!"}
	end

	def destroy_tracks
		user = current_user.id
		track =  User.find(user).playlists.where(name: 'tracks')[0].id
		PlaylistsTrack.where(playlist_id: track, song_id: params[:id])[0].delete
		render json: {success: "removed from tracks!"}
	end

	def destroy
	end



end
