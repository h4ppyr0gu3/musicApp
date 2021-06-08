class SearchesController < ApplicationController

	def search_results
	end

	def search_music
		searched_songs = MusicServices::YoutubeSearch.execute!(params[:query])
		render json: searched_songs 
	end

	def search_db
		@q = Song.ransack(params[:q])
  	@songs = @q.result(distinct: true)
  	items = []
  	@songs.each do |s|
  		entry = {}
			array = Array.new
			artist = Artist.joins(:collabs).where(collabs: { song_id: s.id})
			artist.each do |a|
				array.push(a.name)
			end
			artists = array&.join(", ")
			song = [s.yt_title, s.song_name, s.id]
			entry["name"] = s&.song_name
			entry["artists"] = artists
			entry["yt"] = s.yt_title
			entry["src"] = url_for(s&.music_file)
			entry["img"] = s.album_art_url
			entry["status"] = s.status
			entry["id"] = s.id
			items.push(entry)
		end
		render json: {"items": items}
	end

	private

	def searched_songs
	end
end
