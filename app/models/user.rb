class User < ActiveRecord::Base
  has_many :tasks
  has_many :responsible_tasks, foreign_key: :responsible_id, class_name: 'Task'
  has_many :created_tasks, foreign_key: :creator_id, class_name: 'Task'

  devise :database_authenticatable, :registerable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  def online?
    updated_at > 10.minutes.ago
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    if auth.info.email
      user = User.where(email: auth.info.email).first
    else
      user = User.where(provider: auth.provider, uid: auth.uid).first
    end

    attributes = { name: auth.extra.raw_info.name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email }
    if user
      user.update_attributes(attributes)
    else
      user = User.create(attributes.merge(password: Devise.friendly_token[0,20]))
    end
    user
  end
end
