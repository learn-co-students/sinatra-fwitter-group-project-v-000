class Tweet < ActiveRecord::Base
  include Slugable::InstanceMethods

  has_secure_password

  belongs_to :user

  def self.find_by_slug(slug)
      self.all.find do |instance|
       instance.slug == slug
  end
  end

end
