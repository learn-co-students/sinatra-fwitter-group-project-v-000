require './config/environment'
require "pry"
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "time again"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      @user ||= User.find(session[:id])
    end

  end

end
