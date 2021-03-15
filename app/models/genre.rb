class Genre < ApplicationRecord
	belongs_to :song
	has_many :artists through :songs
end
