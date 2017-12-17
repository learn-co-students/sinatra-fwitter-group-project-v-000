require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def logout
      session.destroy
    end

    def complete_info_signup?
      !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
    end

    def complete_info_login?
      !params[:username].empty? && !params[:password].empty?
    end
  end
end
