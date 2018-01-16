class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password
  has_secure_password

    def slug
			self.username.downcase.gsub(" ", "-")
	end

    def self.find_by_slug(slug)
			User.all.find {|user| user.slug == slug}
	end

end


# slug = @user.slug
#     expect(User.find_by_slug(slug).username).to eq("test 123")
