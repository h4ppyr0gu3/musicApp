class Playlist < ApplicationRecord
	has_many :playlists_users
	has_many :playlists_tracks
	has_many :users, through: :playlists_users
	has_many :songs, through: :playlists_tracks
	validates :name, presence: true
end
