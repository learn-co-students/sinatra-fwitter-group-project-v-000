class Tweet < ActiveRecord::Base 
  belongs_to :user
  # extend Slug::ClassMethods
  # include Slug::InstanceMethods

  
  def slug
    self.username.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
  end


  def self.find_by_slug(value)
    self.all.detect{ |a| a.slug == value}
  end
  
  
end