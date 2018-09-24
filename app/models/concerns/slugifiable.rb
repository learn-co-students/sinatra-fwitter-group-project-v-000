class Slugifiable
    def slug
        name = self.name
        slugged = username.downcase.gsub(" ", '-')
        slugged
    end

    def self.find_by_slug(slug)
        name = slug.split('-').join(" ")
        self.all.detect{|i| i.username.downcase == name}
    end
end