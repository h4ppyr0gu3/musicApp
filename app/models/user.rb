class User < ApplicationRecord
	has_many :playlists_user
	has_many :playlists, through: :playlists_user
	has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]


	def self.create_from_provider(provider_data)
		where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
			user.email = provider_data.info.email
			user.password = Devise.friendly_token[0, 20]
		end
	end

end
