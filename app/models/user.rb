class User < ActiveRecord::Base
  after_create :add_slug

  has_many :tweets
  has_secure_password

  validates :username, presence: true, uniqueness:true
  validates :email, presence: true, uniqueness:true
  validates :password, presence: true


  def add_slug
    slug = username.split(' ').join('-').gsub(/(\.|!|\?|\(|\)|&|%|@)/, '').gsub('$', 's')
    update slug: slug.downcase
  end
end
