class Song < ApplicationRecord
	has_one_attached :music_file
	belongs_to :artist

end
