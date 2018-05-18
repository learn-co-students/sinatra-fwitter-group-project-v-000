require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "soup"
  end

  get '/' do
    erb :index
  end

  def current_user
    if !!session[:user_id]
      User.find_by_id(session[:user_id])
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

end
