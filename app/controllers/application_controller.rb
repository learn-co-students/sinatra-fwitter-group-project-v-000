require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  def loggedin?
    session[:id] != nil
  end

  get '/' do
     @session = session
     erb :index

  end


end
