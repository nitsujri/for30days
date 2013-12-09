class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :tasks

  # Facebook Stuffs ===============================================

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(
                          display_name: auth.extra.raw_info.name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20],
                          fb_access_token: auth.credentials.token,
                          time_zone: "Pacific Time (US & Canada)"
                         )
    else
      if user and user.confirmed?
        user.update_attribute('fb_access_token', auth.credentials.token)
      end
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
