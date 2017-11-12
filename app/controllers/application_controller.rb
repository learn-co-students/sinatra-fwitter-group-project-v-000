require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use RackSessionAccess if environment == :test
  end

  get '/' do
    erb :"index"
  end

  get '/signup' do 
    if logged_in?
  
      redirect "/tweets"
    else
      erb :"signup"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect "/signup"
    else
      redirect "/tweets"
    end
  end

  get '/login' do
    erb :"login"
  end


  post '/login' do
    if params[:username] == "" || params[:password] == ""
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

  get '/tweets' do
    "test"
  end



  ### Helpers ###
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end