class UserProvider < ApplicationRecord
  belongs_to :user

  def self.find_for_facebook_oauth(auth)
    user = UserProvider.where(provider: auth.provider, uid: auth.uid).first
    unless user.nil?
      user.user
    else
      registered_user = User.where(email: auth.info.email).first || User.where(username: auth.info.name).first
      unless registered_user.nil?
        UserProvider.create!(
          provider: auth.provider,
          uid: auth.uid,
          user_id: registered_user.id
        )
        registered_user
      else
        gender ||= auth.extra.raw_info.gender
        user = User.new(
          username: auth.info.name,
          email: auth.info.email,
          gender: gender,
          password: Devise.friendly_token[0,20],
        )
        user.provider = user.uid = true
        user.save

        user_provider = UserProvider.create!(
          provider:auth.provider,
          uid:auth.uid,
          user: user
        )
        user
      end
    end
  end

    def self.find_for_google_oauth(auth)
      user = UserProvider.where(provider: auth.provider, uid: auth.uid).first
      unless user.nil?
        user.user
      else
        registered_user = User.where(email: auth.info.email).first || User.where(username: auth.info.name).first
        unless registered_user.nil?
          UserProvider.create!(
            provider: auth.provider,
            uid: auth.uid,
            user_id: registered_user.id
          )
          registered_user
        else
          gender ||= auth.extra.raw_info.gender
          user = User.new(
            username: auth.info.name,
            email: auth.info.email,
            gender: gender,
            password: Devise.friendly_token[0,20],
          )
          user.provider = user.uid = true
          user.save

          user_provider = UserProvider.create!(
            provider:auth.provider,
            uid:auth.uid,
            user: user
          )
          user
        end
      end
    end
end
