class Tweet < ActiveRecord::Base
	belongs_to :user

	def slug
      self.username.gsub(" ", "-").downcase
    end

    def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
end
