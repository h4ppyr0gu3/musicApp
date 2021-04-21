class TracksController < ApplicationController

	before_action :authenticate_user!

	def index
		# @all_tracks = Track.where(
			# user_id: current_user.id
		# ).song
	end

	def all_tracks
		@user = current_user.id
		users_tracks = Song.joins(:tracks).where(tracks: { user_id: @user})
		users_tracks = users_tracks.reject{ |s| s.music_file.attached? = false}
		items = []
		users_tracks.each do |s|
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
		response = {items: items}
		render json: response
	end

	def create
		puts params
		Track.create!(user_id: current_user.id, song_id: params[:id])
		render json: {success: "added successfully"}
	end

	def edit
	end

	def destroy
		user = current_user.id
		track = Track.where(user_id: user, song_id: params[:id])
		track.each do |t|
			t.destroy
		end
		render json: {success: "removed from tracks!"}
	end



end