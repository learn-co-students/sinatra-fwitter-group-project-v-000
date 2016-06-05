class User < ActiveRecord::Base
  include Slugifiable

  validates :username, :email, presence: true
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    self.find { |s| s.slug == slug } 
  end

 end
