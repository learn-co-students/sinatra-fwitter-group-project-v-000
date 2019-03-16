require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get "/" do
  erb :"homepage"
  end



  def current_user
    @user ||= User.find_by_id(session[:user_id])
  end

  def is_logged_in?
    !!current_user
    #!!session[:user_id]
  end





end
