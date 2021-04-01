class Artist < ApplicationRecord
	has_many :songs, through: :collabs 
	
end
