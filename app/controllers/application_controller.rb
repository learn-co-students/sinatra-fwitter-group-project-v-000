require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:id]
    end

    def logout!
      session.clear
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end
  end



end