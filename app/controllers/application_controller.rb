require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

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
    if User.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'users/create_user'
    end

  end 

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      @user.save 
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      flash[:notice] = "Please enter a valid username, email and password to Join Fwitter!"
      redirect '/signup'
    end 
  end 


end