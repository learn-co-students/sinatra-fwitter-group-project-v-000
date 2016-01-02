class User < ActiveRecord::Base

  has_many :tweets

<<<<<<< HEAD
=======
  def slug
    self.username
  end

>>>>>>> 440600a5acd950868409d65b745bf359608dfce0
end