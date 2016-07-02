require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #binding.pry
    erb :index
  end

  get '/logout' do
    if logged_in?
      session[:id] = nil
    end
    redirect "/login"
  end


  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end
