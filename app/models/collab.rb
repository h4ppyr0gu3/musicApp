class Collab < ApplicationRecord
	has_one :artist
	has_one :song
end
