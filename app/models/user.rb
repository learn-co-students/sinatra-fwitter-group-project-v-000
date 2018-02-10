class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
  has_many :tweets

  def slug
    self.name.downcase.gsub(" ","-").gsub(/[^a-zA-Z0-9-]/, "")
  end

  def find_by_slug(search_slug)
    self.all.detect{|i| i.slug == search_slug}
  end

  def self.current_user(session_hash)
    user = User.find(session_hash[:user_id])
  end

  def self.is_logged_in?(session_hash)
    user = User.find(session_hash[:user_id]) if session_hash[:user_id]
    if user
      !!user
    else
      user
    end
  end
end

end
