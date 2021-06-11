class Friendship < ApplicationRecord

	belongs_to :user
	belongs_to :friend, :class_name => "User"

	enum status: %i[ pending confirmed declined ]

	scope :pending, -> { where(status: 0) }
	scope :confirmed, -> { where(status: 1) }
	scope :declined, -> { where(status: 2) }

	validates_uniqueness_of :user_id, :scope => :friend_id
	validates :user_id, uniqueness: {scope: :friend_id}
	validates :user_id, exclusion: { in: ->(friendship) { [friendship.friend_id] } }

end
