class Tweet < ActiveRecord::Base 
  belongs_to :user
  
  
  def slug
    self.username.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
  end


  def find_by_slug(value)
    self.all.detect{ |a| a.slug == value}
  end
  
  
end