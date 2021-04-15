class PlaybackController < ApplicationController
	before_action :authenticate_user!

	def play
		render json: url_for(Song.first.music_file)
	end

	def pause
	end

	def next
	end

	def prev
		puts params
		response = {url: url_for(Song.find(8).music_file)}
		render json: response
	end

	def show
	end

end