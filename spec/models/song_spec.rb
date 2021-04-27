require 'rails_helper'

RSpec.describe Song, type: :model do 
	context 'validation tests' do
		it 'ensure yt_title is not nil' do
			song = Song.new(song_name: "", yt_title: "", album_art_url: "something").save
			expect(song).to eq(false)
		end

		it 'ensure album_art_url is present' do
			song = Song.new(song_name: "", yt_title: "something", album_art_url: "").save
			expect(song).to eq(false)
		end

		it 'ensure valid save' do
			song = Song.new(song_name: "", yt_title: "something", album_art_url: "something").save
			expect(song).to eq(true)
		end
	end
end