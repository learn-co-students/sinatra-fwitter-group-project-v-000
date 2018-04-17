require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test?
    set :session_secret, "secret"
  end

  helpers do #block allows you to create helper methods
    def logged_in
      !!current_user
    end

    def current_user
      session.include?("user_id")
    end
  end

  get '/' do
    erb :'index'
  end

end
