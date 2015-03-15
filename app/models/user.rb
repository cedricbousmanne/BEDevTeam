class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  acts_as_taggable_on :skills, :interests

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  class << self
    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
          user.name = auth['info']['name'] || ""
          user.email = auth['info']['email'] || ""
          user.image = auth['info']['image'] || ""
          user.description = auth['info']['description'] || ""
          user.location = auth['info']['location'] || ""
          user.headline = auth['info']['headline'] || ""
          user.linkedin_profile = auth['info']['urls']['public_profile'] || ""
        end
      end
    end

    def editable_attributes
      %w(name headline description location email image linkedin_profile skill_list interest_list)
    end
  end
end
