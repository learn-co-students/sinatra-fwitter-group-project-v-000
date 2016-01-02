class User < ActiveRecord::Base

  has_many :tweets

  def slug
    self.username
  end
<<<<<<< HEAD


=======
  
>>>>>>> d99a3f271b93be0f1eba5380908fcaff6cf63759
end