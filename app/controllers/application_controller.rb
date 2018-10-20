require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "my_application_secret"
    enable :sessions
  end

  get '/' do
    erb :index
  end

  def logged_in?
    !!@current_user #this is an object and need to make it a boolean for false/true
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] #if this is true
  end

end
