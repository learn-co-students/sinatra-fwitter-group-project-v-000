require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
      erb :index
  end

  get '/signup' do
    if !session[:user_id] 
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if !session[:user_id]
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/show'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :login
    else
      @user = User.find_by_id(session[:user_id])
      redirect '/tweets'
    end
  end

  post '/login' do 
    if !session[:user_id]
      @user = User.find_by(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      @user = User.find_by_id(session[:user_id])
      redirect '/tweets'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show'
  end


end