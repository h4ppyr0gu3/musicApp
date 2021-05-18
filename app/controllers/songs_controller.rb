class SongsController < ApplicationController

	before_action :authenticate_user!

	def index 
	
	end

	def all_songs
		@user = current_user.id
		users_tracks = User.find(@user).playlists.find_by(name: 'tracks').songs
		@all_songs = Song.all
		@users_song_ids = []
		users_tracks.each do |el|
			@users_song_ids.push(el.id)
		end
		items = []
		@all_songs.each do |s|
			entry = {}
			array = []
			artist = Artist.joins(:collabs).where(collabs: { song_id: s.id})
			artist.each do |a|
				array.push(a.name)
			end
			artists = array&.join(", ")
			song = [s.yt_title, s.song_name, s.id]
			entry["name"] = s&.song_name
			entry["artists"] = artists
			entry["yt"] = s.yt_title
			entry["src"] = url_for(s&.music_file)
			entry["img"] = s.album_art_url
			entry["status"] = s.status
			entry["id"] = s.id
			items.push(entry)
		end
		response = {items: items}
		render json: response
	end

	def create
		if user_signed_in?
			user = current_user.id
		else 
			user = nil
		end
		Song.create(
			video: params["video"], 
			thumbnail: params["thumbnail"], 
			title: params["title"], 
			user: user 
		)
		render json: {success: "Download started"}
	end

	def destroy
		Song.find(params[:id]).destroy
		render json: {success: "destroyed"}
	end

	def confirm
		song = Song.find(params[:id])
		title = params[:title]
		title = title.strip
		song.update!(status: :confirmed, song_name: title)
		artists = Collab.where(song_id: params[:id])
		artists.each do |collab|
			collab.destroy
		end
		artists = params[:Artists]
		artists = artists.reject { |c| c.empty? }
		artists = artists.reject { |c| c.blank? }
		artists = artists.map { |c| c.strip }
		array = []
		artists.each do |artist|
			collab = Artist.find_or_create_by!(name: artist)
			array.push(collab.id)
		end
		song.update!(artist_ids: array)
		AttributesWorker.perform_async(params[:id])
		response = {success: "created!"}
		render json: response
	end


	def edit_again
		song = Song.find(params[:id])
		song.update!(status: :pending)
	end

	before_action :authenticate_user!

	def tracks_index
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


end
