require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  configure do
    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do
    erb :index
  end


  helpers do
  def logged_in?
    !!current_user
  end


  def current_user(session)
      @user_id = User.find_by_id(session[:user_id])
    end
  end

end
