class Artist < ApplicationRecord
	has_many :collabs
	has_many :songs, through: :collabs 
	
end
