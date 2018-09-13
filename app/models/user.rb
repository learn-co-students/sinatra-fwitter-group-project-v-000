class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    value = self.username.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '-')
    value
  end

  def self.find_by_slug(slug)
    self.find { |obj| obj.slug == slug }
  end

end
