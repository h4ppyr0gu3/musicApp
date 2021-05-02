class SearchesController < ApplicationController

	def search_results
	end

	def search_music
		searched_songs = MusicServices::YoutubeSearch.execute!(params[:query])
		render json: searched_songs 
		# redirect_to ruby_search_path(searched_songs)
	end

	private

	def searched_songs
	end
end
