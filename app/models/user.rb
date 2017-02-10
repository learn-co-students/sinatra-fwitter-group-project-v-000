class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  #validates :username, :email, :password, presence: true
  has_many :tweets
  has_secure_password

  def slug
    title = self.username
    conj = ["for", "and", "or", "nor", "but", "yet", "so"] #Remove conjunctions
    conj.collect! {|conj| "\b"+conj} #Add "\b" to only pick independent word conjunctions and not embedded in a word
    #result = title.downcase.strip.gsub(Regexp.union(conj), '').squeeze(" ").gsub(' ', '-').gsub(/[^\w-]/, '')
    result = title.downcase.strip.gsub(Regexp.union(conj), '').squeeze(" ").gsub(' ', '-').gsub(/[^\w-]/, '').squeeze("-")
  end

  def self.find_by_slug(slug)
    result = {}
    self.all.each do |object|
      if object.slug == slug
        result = object
      end
    end
    result
  end

end
