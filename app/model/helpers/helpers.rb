module Helpers
  module ClassMethods

  end

  module InstanceMethods
    def is_logged_in?
      return true if session[:id] != nil
    end
  end
end
