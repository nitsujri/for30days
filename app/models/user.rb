class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :tasks

  # Facebook Stuffs ===============================================

  def absorb_graph_data
    graph = Koala::Facebook::API.new(self.fb_access_token)
    self.profile_picture = graph.get_picture("me")
    self.save
  end

  class << self

    def find_for_facebook_oauth(auth, signed_in_resource=nil)
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
        #Found the user, let's update their FB access token
        if user
          user.update_attribute('fb_access_token', auth.credentials.token)
        end
      end

      #Let's go get stuff we want to use A LOT
      user.absorb_graph_data

      user
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
