module Ownable
  module InstanceMethods
    def current_user_owns(obj)
      current_user.id == obj.user_id
    end
  end
end
