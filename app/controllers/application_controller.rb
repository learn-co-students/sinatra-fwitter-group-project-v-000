require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, 'secret_password'
    
  end

  get '/' do
    #binding.pry
    erb :index
  end

  helpers do
    def is_logged_in
      session[:user_id] ? true : false
    end

    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end