class SongsController < ApplicationController

	def index
		@index = Song.all
	end

	def new
	end

	def create
		Song.create!(video: params[:video], thumbnail: params[:thumbnail])
		render json: {state: "Download started"}
	end

	def update
	end

	def destroy
	end

	def edit
	end

	def homepage_search
		puts params
		redirect_to root_path
	end

	private

	def push_to_active_storage filename, song
		song.music_file.attach(
		  io: File.open(Rails.root.join("tmp/downloads/#{filename}")),
		  filename: "#{filename}",
		  content_type: 'audio/mp3'
		)
	end
end
