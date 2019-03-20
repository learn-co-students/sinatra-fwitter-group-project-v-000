require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "beavis"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    if logged_in?
      User.find(session[:user_id])
    end
  end

end
