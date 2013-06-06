class User < ActiveRecord::Base
  has_many :tasks
  has_many :responsible_tasks, foreign_key: :responsible_id, class_name: 'Task'
  has_many :created_tasks, foreign_key: :creator_id, class_name: 'Task'

  devise :database_authenticatable, :registerable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  def online?
    updated_at > 10.minutes.ago
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name: auth.extra.raw_info.name,
                          provider: auth.provider,
                          uid: auth.uid,
                          email: auth.info.email,
                          password: Devise.friendly_token[0,20]
                          )
    end
    user
  end
end
