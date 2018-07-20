class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    @slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    @slug
  end

  def self.find_by_slug(slug)
    words_to_ignore = ["the", "of", "with", "a"]
    new_slug = slug.gsub("-", " ").split(/ |\_/)#.map do |word|
  #     unless words_to_ignore.include?(word)
  #       word.capitalize
  #     else
  #       word
  #   end
  # end
    new_slug = new_slug.join(" ")
    self.find_by(username: new_slug)
  end

end
