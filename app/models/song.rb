class Song < ApplicationRecord

	attr_accessor :video, :thumbnail, :title, :user

	enum status: %i[ pending confirmed ]

	has_one_attached :music_file
	has_many :tracks
	has_many :collabs
	has_many :artists, through: :collabs
	has_many :users, through: :tracks

	before_validation :checklist

	validates :album_art_url, presence: true
	validates :yt_title, presence: true

	def checklist
		return if @video.nil? || @thumbnail.nil? || @title.nil?
		DownloadsWorker.perform_async({
			video: @video, 
			thumbnail: @thumbnail, 
			title: @title, 
			user: @user
		})
	end
end
