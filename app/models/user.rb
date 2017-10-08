class User <ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub('-', ' ')
    all_users = User.all
    all_users.each do |user|
      if user.username.downcase == unslug
        return user
      end
    end
  end

  def authenticate(password)
    if self.password == password
      return self
    else
      return false
    end
  end

end
