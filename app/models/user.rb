class User < ApplicationRecord
	has_many :tracks
	has_many :songs, through: :tracks
	has_one_attached :image do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

	
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]

	def self.create_from_provider(provider_data)
		where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
			user.email = provider_data.info.email
			user.password = Devise.friendly_token[0, 20]
		end
	  # name_split = auth.info.name.split(" ")
	  # user = User.where(email: auth.info.email).first
	  # user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
	  #   user
	end

end
