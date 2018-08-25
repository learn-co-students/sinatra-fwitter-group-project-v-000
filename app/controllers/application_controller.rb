require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/tweets' do
    if session[:id]
    erb :tweets
  else
    redirect to('/login')
  end
  end

  get '/signup' do
    if session[:id]
      redirect to('/tweets')
    else
    erb :signup
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
    user = User.create(username: params[:username], email: params[:email], password: params[:email])
    session[:id] = user.id
    redirect to('/tweets')
    else
    redirect to('/signup')
    end
  end

  get '/login' do
    if session[:id]
      redirect to('/tweets')
    else
    erb :login
    end
  end

  post '/login' do
     user = User.find_by(username: params[:username])
    #  binding.pry
     if user && user.authenticate(params[:password])
     session[:id] = user.id
     redirect to('/tweets')
    else
     redirect to('/login')
     end
  end

  get '/logout' do
    session.clear
    redirect to('/login')
  end



end
