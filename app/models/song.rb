class Song < ApplicationRecord

	attr_accessor :video, :thumbnail, :title, :user

	enum status: %i[ pending confirmed ]

	has_one_attached :music_file
	has_many :tracks
	has_many :collabs
	has_many :artists, through: :collabs
	has_many :users, through: :tracks

	before_save :checklist

	def checklist
		DownloadsWorker.perform_async({
			video: @video, 
			thumbnail: @thumbnail, 
			title: @title, 
			user: @user
		})
	end
end
