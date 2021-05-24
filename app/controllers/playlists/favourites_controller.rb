class Playlists::FavouritesController < ApplicationController
  def index; end

  def index_api
  	@user = current_user.id
		users_tracks =  User.find(@user).playlists.where(name: 'favourites')[0].songs
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

 	def update
		playlist = User.find(current_user.id).playlists.find_or_create_by!(name: "favourites", admin_user: current_user.id)
		PlaylistsTrack.find_or_create_by!(song_id: params[:id], playlist_id: playlist.id)
		render json: {success: "created"}
	end 

	def destroy
	end 
end