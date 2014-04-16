class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]
   def self.find_or_create_for_twitter_oauth(auth)
     where(auth.slice(:provider, :uid)).first_or_create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.email = auth.info.nickname + "@twitter.com"
         user.password = Devise.friendly_token[0,20]
     end
   end
end
