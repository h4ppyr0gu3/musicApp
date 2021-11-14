class DownloadsWorker
  include Sidekiq::Worker
 	sidekiq_options retry: 1

  def perform params
  	method_name(params)
  end 
  	
	def method_name params
		info = MusicServices::Attributes.execute!(params["title"])
		songname = info[0].join(" ")
		puts params["user"]
		search = Song.find_by(yt_title: params["title"])
		if search == nil
			videoUrl = params["video"]
			title = MusicServices::DownloadVideo.execute!(videoUrl)
			title = title.sub(".mp4", ".mp3")
			title = title.sub(".webm", ".mp3")
			title = title.gsub("\n", "")
			song = Song.create!(song_name: songname, album_art_url: params["thumbnail"], status: :pending, yt_title: params["title"])
			song.update!(artist_ids: info[2])
			push_to_active_storage(title, song)
			if params["user"] != nil
				playlist = User.find(params["user"]).playlists.find_or_create_by!(name: "tracks", admin_user: params["user"])
				PlaylistsTrack.create!(song_id: song.id, playlist_id: playlist.id)
			end
		else
			if params["user"] != nil
				playlist = User.find(params["user"]).playlists.find_or_create_by!(name: "tracks", admin_user: params["user"])
				PlaylistsTrack.create!(song_id: search.id, playlist_id: playlist.id)
			end
		end
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
