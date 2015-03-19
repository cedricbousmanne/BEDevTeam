class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  acts_as_taggable_on :skills, :interests
  geocoded_by :location
  after_validation :geocode
  dragonfly_accessor :image
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_format_of :linkedin_profile, allow_blank: true, allow_nil: true, with: /(https:\/\/([a-z]{2,3}\.)?linkedin.com\/(in|pub)\/(.{1,}))/
  validates_format_of :twitter_profile , allow_blank: true, allow_nil: true, with: /(https:\/\/(www\.)?twitter.com\/(.{1,}))/
  validates_format_of :github_profile  , allow_blank: true, allow_nil: true, with: /(https:\/\/(www\.)?github.com\/(.{1,}))/

  validates :name,     presence: true
  validates :headline, presence: true, on: :update
  validates :location, presence: true, on: :update
  validates :email,    presence: true

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def coordinates
    [latitude, longitude]
  end

  class << self
    def oauth_client(auth, provider)
      linked_in_client(auth) if provider == "linkedin"
    end

    def linked_in_client(auth)
      client = LinkedIn::Client.new
      client.authorize_from_access(auth.extra.access_token.token, auth.extra.access_token.secret)
      client
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        client = oauth_client(auth, auth['provider'])
        create_with_provider(user, auth['provider'], auth['info'], client)
      end
    end

    def create_with_provider(user, provider, info, client)
      case provider
      when "linkedin"
        create_with_linkedin(user, info, client)
      when "github"
        create_with_github(user, info, client)
      end
    end

    def create_with_linkedin(user, info, client)
      if info
        user.name             = info['name'] || ""
        user.email            = info['email'] || ""
        user.description      = info['description'] || ""
        user.location         = info['location'] || ""
        user.headline         = info['headline'] || ""
        user.linkedin_profile = info['urls']['public_profile'] || ""
        user.image_url        = get_image(user, client)
      end
    end

    def create_with_github(user, info, client)
      if info
        user.name             = info['name'] || ""
        user.email            = info['email'] || ""
        user.github_profile   = info['urls']['GitHub'] || ""
        user.image_url        = info['image'] || ""
      end
    end

    def get_image(user, client)
      begin
        client.picture_urls.all.first
      rescue
        "#{ENV['DOMAIN_NAME']}/assets/default_user.png"
      end
    end

    def editable_attributes
      %w(name headline description location email image linkedin_profile twitter_profile github_profile skill_list interest_list)
    end
  end
end
