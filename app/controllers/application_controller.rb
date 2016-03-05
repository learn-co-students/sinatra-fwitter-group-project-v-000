require 'pry'
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
     redirect to '/tweets' 
    end
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/tweets' do
    @user = current_user
    erb :'tweets/tweets'
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username]) 
    if !!user && user.authenticate(params[:password])
      session[:id] = user.id
    end
    redirect "/tweets"
  end

  get '/logout' do
    session.clear
  end

  #helper methods
  helpers do

    def current_user
      User.find_by(id: session[:id])
    end

    def logged_in?
      !!session[:id]
    end
  end
end