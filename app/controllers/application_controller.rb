require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    set :public_folder, 'public'
    enable :sessions
    
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
      @current_user ||= session[:user_id] &&
      User.find_by(id: session[:user_id])
    end
  end

end