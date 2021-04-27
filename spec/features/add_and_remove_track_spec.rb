require 'spec_helper'
require 'rails_helper'

RSpec.describe 'song added and removed depending on path', type: :feature do
	context 'Tracks' do 
		it 'does something' do
			visit root_path
			click_link 'Search Now!'
	    expect(page).to have_current_path(search_results_path)
	    find('#query').set('yes kyle')
	    fill_in 'query', with: 'yes kyle'
	    click_button 'Search'
	    click_button("DOWNLOAD", match: :first)
	    click_button("Download")
	    expect(page).to have_content('You need to sign in or sign up before continuing.')
			click_link 'Sign up'
	    fill_in 'user[email]', with: 'test@test.com'
	    fill_in 'user[password]', with: 'password'
	    fill_in 'user[password_confirmation]', with: 'password'
	    click_button 'Sign up'
	    expect(page).to have_current_path(root_path)
	    click_link 'Search Now!'
	    expect(page).to have_current_path(search_results_path)
	    find('#query').set('yes kyle')
	    fill_in 'query', with: 'yes kyle'
	    click_button 'Search'
	    click_button("DOWNLOAD", match: :first)
	    expect(page).to have_css(".download")
	    click_button("Download")
	    click_button("PLAY", match: :first)
	    expect(page).to have_css("iframe")
		end

		it 'track add and remove' do 
			song = Song.create!(song_name: "Hilding on",
				yt_title: "iann dior - Holding On (Official Music Video).mp3",
				album_art_url: "https://i.ytimg.com/vi/BMmUkrUehrM/mqdefault.jpg"
			)
			song.music_file.attach(
			  io: File.open(Rails.root.join'spec/iann dior - Holding On (Official Music Video).mp3'),
			  filename: 'shamwari yangu',
			  content_type: 'audio/mp3'
			)
	    song.artists.create!(name: "iann Dior")
	    song = Song.create!(song_name: "3, 2, 1", 
	    	yt_title: "24kGoldn - 3, 2, 1 (Official Video).mp3", 
	    	album_art_url: "https://i.ytimg.com/vi/WbHfQgVi1GA/mqdefault.jpg"
	    )
	    song.music_file.attach(
			  io: File.open(Rails.root.join'spec/24kGoldn - 3, 2, 1 (Official Video).mp3'),
			  filename: 'Sadza nuggies',
			  content_type: 'audio/mp3'
			)
	    song.artists.create!(name: "24kGoldn")
			visit root_path
			click_link 'Sign up'
	    fill_in 'user[email]', with: 'test@test.com'
	    fill_in 'user[password]', with: 'password'
	    fill_in 'user[password_confirmation]', with: 'password'
	    click_button 'Sign up'
	    expect(page).to have_current_path(root_path)
	    click_link "All songs"
		end
	end
end