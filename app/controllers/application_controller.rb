require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do
    # binding.pry
    if !logged_in 
      erb :signup
    else
     erb :tweets
    end
  end

  post '/signup' do
    if valid_new_user(params)
      @user = User.new(username: params[:username],email: params[:email],password_digest: BCrypt::Password.create(params[:password]))
      @user.save
      session[:id] = @user.id
      # binding.pry
      redirect '/tweets'
    else
      # erb :'/signup', locals: {message: "Enter valid information."}
      redirect '/signup'
    end
  end 

  get '/login' do 
    erb :login
  end

  post '/login' do 
    user = User.find_by(username: params[:username])
    # binding.pry
    if user && user.authenticate(params[:password])
      # binding.pry
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets' do 
    erb :tweets
  end

  get '/logout' do 
    session.clear
    redirect '/'
  end

  helpers do 
    def valid_new_user(params)
      user = User.find_by(username: params[:username])
      if params[:username] == ''
        false
      elsif params[:password] == ''
        false
      elsif params[:email] == ''
        false
      elsif user != nil
        false
      else
        true
      end
    end

    def logged_in
      # binding.pry
      !!session[:id]
    end
  end
end