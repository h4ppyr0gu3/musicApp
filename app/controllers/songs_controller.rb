class SongsController < ApplicationController

	attr_accessor :song

	def index
	end

	def new
	end

	def create
	end

	def update
	end

	def destroy
	end

	def edit
	end

	private

	def push_to_active_storage filename
		@song.music_file.attach(
		  io: File.open(Rails.root.join('tmp/downloads/#{filename}')),
		  filename: '#{filename}.mp3',
		  content_type: 'audio/mp3'
		)
	end
end
