module Slugifiable
  extend ActiveSupport::Concern

  def slug
    self.username.gsub(/(\s|\W)/, "-").downcase
  end
  

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect{|a| a.slug == slug}
    end 
  end

  class ActiveRecord::Base
    include Slugifiable 
  end
end

=begin


  I kept my version and deleted yours for a couple reasons:
    1) Mine uses ActiveSupport to handle instance/class variable assignment, 
    then includes it in ActiveRecord::Base, so it's automatically included
    in each model. One file to check. 
    --as far as I can tell, this is how the AS is supposed to be set up,
    based on a lot of reading; but I'm not convinced this is the best
    or more current way to do it. It just worked flawlessly
      for me before, so I copied it over. 

    2) My slug method is slightly more robust, since it looks for special characters,too.
    in practice, this is probably never going to matter like it did with
    playlister. But I figure it would catch more user stupidity, which 
    I always plan for people to be stupider than I thought. 
    --Or, not being a dick about it, I haven't accounted for all the stuff people
    could do with their usernames anywhere else in my code & this check 
      seems like it'll catch more stuff, leaving a smaler pool or potential 
      errors in the future. 
      --This is probably overdone for what we have to do here.

    3) Basically it's probably my neurosis or OCD or whatever pop-psych
    nonsense you want. I just don't wanna step on toes. 

  Your original slugs.rb code is saved in the comment below. I won't go to
  the barricades over this, so if you wanna use yours, it's there.  

=end

=begin
module Slug
  module InstanceSlugs

    def slug
      self.username.downcase.gsub(' ', '-')
    end
  end

  module ClassSlugs

    def find_by_slug(text)
      self.find{|w| w.slug == text}
    end
  end
end


=end