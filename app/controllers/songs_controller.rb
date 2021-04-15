class SongsController < ApplicationController

	before_action :authenticate_user!

	def index 
	
	end

	def all_songs
		@user = current_user.id
		users_tracks = Song.joins(:tracks).where(tracks: { user_id: @user})
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
			entry["src"] = url_for(s.music_file)
			entry["img"] = s.album_art_url
			entry["status"] = s.status
			entry["id"] = s.id
			items.push(entry)
		end
		response = {items: items}
		render json: response
	end

	def new
	end

	def create
		if user_signed_in?
			user = current_user.id
		else 
			user = nil
		end
		Song.create!(
			video: params["video"], 
			thumbnail: params["thumbnail"], 
			title: params["title"], 
			user: user 
		)
		render json: {state: "Download started"}
	end

	def update
	end

	def destroy
		Song.find(params[:id]).destroy
		redirect_to songs_path
	end

	def edit
	end

	def confirm
		song = Song.find(params[:id])
		song.update!(status: :confirmed, song_name: params[:title])
		artists = Collab.where(song_id: params[:id])
		artists.each do |collab|
			collab.destroy
		end
		artists = params[:Artists]
		artists = artists.reject { |c| c.empty? }
		array = []
		artists.each do |artist|
			collab = Artist.find_or_create_by!(name: artist)
			array.push(collab.id)
		end
		song.update!(artist_ids: array)
		response = {success: "created!"}
		render json: response


	end

	def homepage_search
		redirect_to root_path
	end

end
