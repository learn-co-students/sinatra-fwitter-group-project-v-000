require 'sinatra/base'

module SessionHelpers

    def is_logged_in?(session)
      !!session[:id]
    end

    def current_user(session)
      User.find_by_id(session[:id])
    end
end

