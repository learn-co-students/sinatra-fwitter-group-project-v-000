class User < ActiveRecord::Base
    # Security
    has_secure_password

    # Relationship
    has_many :tweets

    #Validation
    before_validation :generate_slug    #Generate the slug and insert it in the database
    #validate the presence of username and email
    validates :username, :email, :slug, presence: true

    def generate_slug
        self.slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
        self.find_by(:slug => slug)
    end
end