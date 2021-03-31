class SongsController < ApplicationController

	attr_accessor :index

	def index
		@index = Song.all
	end

	def new
	end

	def create
		videoUrl = params[:video]
		videoTitle = params[:video_title]
		title = MusicServices::DownloadVideo.execute!(params[:videoUrl])
		artist = Artist.create(name: params[:artist])
		song = Song.new(song_name: params[:title], album_art_url: params[:thumbnailUrl], artist_id: artist.id)
		substitute = "-" + params[:videoUrl] + ".webm"
		actual_title = title.sub(substitute, "")
		puts "----------------------------------------------------------------------------------------------------------------"
		puts actual_title
		puts "----------------------------------------------------------------------------------------------------------------"
		push_to_active_storage(actual_title, params[:title], song)
		if song.save!
			redirect_to conditions_path
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

	def homepage_search
		puts params
		redirect_to root_path
	end

	private

	def push_to_active_storage old_filename, new_filename, song
		song.music_file.attach(
		  io: File.open(Rails.root.join("tmp/downloads/#{old_filename}.mp3")),
		  filename: "#{new_filename}",
		  content_type: 'audio/mp3'
		)
	end
end
