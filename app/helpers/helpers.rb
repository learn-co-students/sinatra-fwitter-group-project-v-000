require 'sinatra/base'

module SessionHelpers

    def self.is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by_id(session[:id])
    end
end
# need anything else to be operational? Ask about why not
# current_user(session) formatting
