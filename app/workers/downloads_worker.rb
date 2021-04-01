class DownloadsWorker
  include Sidekiq::Worker
 	# sidekiq_options retry: 1

  def perform params
  	puts params
  	something
  end

  def something
  	puts "we are in the worker now"
  end
  	
	def method_name
		# videoUrl = params[:video]
		# videoTitle = params[:video_title]
		# title = MusicServices::DownloadVideo.execute!(params[:videoUrl])
		# artist = Artist.create(name: params[:artist])
		# song = Song.new(song_name: params[:title], album_art_url: params[:thumbnailUrl], artist_id: artist.id)
		# puts title.encoding
		# substitute = "-" + params[:videoUrl]
		# title = title.sub(substitute, "")
		# title = title.sub(".mp4", ".mp3")
		# title = title.sub(".webm", ".mp3")
		# title = title.gsub("\n", "")
		# puts title 
		# p title
		# puts push_to_active_storage(title, song)
		# if song.save!
		# 	redirect_to conditions_path
		# else
		# 	redirect_to root_path
		# 	puts "failed #{song.errors}"
		# end
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
