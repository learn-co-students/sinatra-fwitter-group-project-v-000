require './config/environment'
require './app/models/user'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "auth_demo_lv"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      User.find_by(:id => session[:user_id])
    end

    def logout!
      session.clear
    end
  end
end


# def login(email)
#   user = User.find_by(:email => email)
#   if user && user.authenticate(password)
#     session[:email] = user.email
#   else
#     redirect '/login'
#   end
# end
