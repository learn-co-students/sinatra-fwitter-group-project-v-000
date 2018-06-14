require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "not that secret but, you know, this isn't the point of this lab"
  end

  get '/' do
    erb :index
  end

  def logged_in?
    !!session[:user_id]
  end

  def user
    User.find(session[:user_id])
  end
end