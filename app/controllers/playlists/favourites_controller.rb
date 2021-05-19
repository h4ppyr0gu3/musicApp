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

	def destroy
	end 
end