require './config/environment'
require "./app/models/user"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end

#renders the index page
get '/' do
  if logged_in?
    redirect "/tweets"
  else
    erb :'/index'
end
end

#help methods to checked if loggin in or not
helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
