class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  has_secure_password
  has_many :tweets
  def slug
    username.downcase.split {|word| word.gsub(/[^0-9A-Za-z]/,"")}.join("-")
  end
  def self.find_by_slug slug
    self.all.detect{|instance| instance.slug==slug }
  end
end
