class SearchesController < ApplicationController

	def set_search
	end

	def search_results
	end

	def search_music
		searched_songs = MusicServices::YoutubeSearch.execute!(params[:query])
		render json: searched_songs 
	end

	private

	def searched_songs
	end
end
