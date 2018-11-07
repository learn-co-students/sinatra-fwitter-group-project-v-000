class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    self.user.username.downcase.gsub(" ", "-")
  end
end
