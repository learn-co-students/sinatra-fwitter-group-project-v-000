require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

#home page and user registration routes ------------------------
  get '/' do 
    erb :index
  end 

  get '/signup' do 
    erb :'users/create_user'
  end 

  post '/signup' do 
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      @user.save 
      session[:id] = @user.id
      redirect to '/tweets'
    else 
      redirect '/signup'
    end 
  end 



end