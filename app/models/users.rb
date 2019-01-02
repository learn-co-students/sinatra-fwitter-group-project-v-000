class User <  ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    new_name = self.username.downcase
    new_name.gsub!(/[!@%&"]/,'')
    new_name.gsub!(/\s/,'-')
    return new_name
  end

  def self.find_by_slug(slug)
    self.all.each do |user|
      if user.slug == slug
        return user
      end
    end
    return nil
  end
end
