class SongsController < ApplicationController

	attr_accessor :song

	def index
	end

	def new
	end

	def create
		videoUrl = params[:video]
		title = MusicServices::DownloadVideo.execute!(params[:video])
		song = Song.new(song_name: title, )
		push_to_active_storage(title, song)
		if song.save
			redirect_to root_path
		else
			redirect_to root_path
			puts "failed #{song.errors}"
		end
	end

	def update
	end

	def destroy
	end

	def edit
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
