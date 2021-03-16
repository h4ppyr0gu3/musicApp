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
				newtitle = title.split("-")
				newtitle.delete_at(-1)
				fulltitle = newtitle.join("-") + ".mp3"
				fulltitle
			end

			def push_to_active_storage filename
				@message.image.attach(
				  io: File.open(Rails.root.join('tmp/downloads/#{filename}')),
				  filename: '#{filename}.mp3',
				  content_type: 'audio/mp3'
				)
			end
		end
	end
end
