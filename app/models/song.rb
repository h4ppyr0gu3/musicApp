class Song < ApplicationRecord

	attr_accessor :video, :thumbnail

	has_one_attached :music_file
	has_many :artist, required: false
	has_many :users, through: :tracks

	before_create :checklist

	def checklist
		puts "AAAAAAAAAAAAAAAAAAAAAAAAAA\n\n\n\n\n"
		DownloadsWorker.perform_async({video: @video, thumbnail: @thumbnail})
	end
end
