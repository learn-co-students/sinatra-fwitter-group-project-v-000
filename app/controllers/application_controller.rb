require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_application_secret"
  end

  get '/' do
    erb :"/index"
  end

  helpers do

    def logged_in?
      # binding.pry
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end

    # def login(email, password)
    #   user = User.find_by(:email => :email => email)
    #   if user && user.authenticate(password)
    #     session[:user_id] = user.id
    #     session[:username] = user.username
    #     session[:email] = user.email
    #     session[:pasword] = user.password
    #     redirect "/tweets"
    #   else
    #     redirect '/login'
    #   end
    # end

    def logout!
      session.clear
    end


  end

end
