class User < ApplicationRecord
	has_many :playlists_user
	has_many :playlists, through: :playlists_user
	has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

  # def pending
  # 	User.joins(:friendships).where(state: 0)
  # end

  # has_many :pending, -> { where(state: 0)}, :class_name => 'Friendships'

	def self.create_from_provider(provider_data)
		where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
			user.email = provider_data.info.email
			user.password = Devise.friendly_token[0, 20]
			user.first_name = provider_data.info.first_name
			user.last_name = provider_data.info.last_name
		end
	end

end
