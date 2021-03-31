# MusicServices::DownloadVideo.execute!
require 'capybara'
require 'capybara/dsl'
require 'nokogiri'
require 'open-uri'

module MusicServices
	class DownloadVideo
		class << self
			def execute! videoUrl
				download_video_to_tmp(videoUrl)
			end

			def download_video_to_tmp videoUrl
				videoUrl = "https://www.youtube.com/watch?v="  + videoUrl
				youtube = Rails.root.join("lib/youtube.sh").to_s
				title = %x{sh #{youtube} #{videoUrl}}
			end

		end
	end
end
