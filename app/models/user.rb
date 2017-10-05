class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def find_by_slug
     self.all.find{|s| s.slug == slug}
  binding.pry
  end
end
