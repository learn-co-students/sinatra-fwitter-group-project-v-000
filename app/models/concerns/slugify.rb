module Slugify

 # module InstanceMethods

    def slugify
      self.username.gsub(/\s+/, "-").downcase
    end


  #end


  #module ClassMethods



  #end


end