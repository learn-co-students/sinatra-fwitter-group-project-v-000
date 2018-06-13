
module Slugable

     module InstanceMethods

          def slug
               self.username.downcase.gsub(" ","-")
              #  we add the "name" line 7 to impact the name of any object we pass in. also ..(self)
          end

     end

    # module ClassMethod

end
