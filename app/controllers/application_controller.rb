require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"    
  end

  get '/' do
    erb :index
  end
  
  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end
  
  get '/login' do
    if session[:id].nil?
      erb :'/users/login'
    else
      redirect '/tweets'
    end
  end
  
  get '/logout' do
    if session[:id]
      session.clear
    else
      redirect '/login'
    end
  end
  
  get '/tweets' do
    if session[:id]
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if session[:id]
      @user = User.find(session[:id])
      erb :'/tweets/create_tweet'
    else
      redirect :'/login'
    end
  end
  
  get '/tweets/edit' do
    erb :'/tweets/edit_tweet'
  end
  
  get '/tweets/:slug' do
    erb :'/tweets/show_tweet'
  end
  
  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username], email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if session[:id].nil?
      redirect '/login'
    else
      @tweet = Tweet.create(content: params[:content], user_id: session[:id])
      redirect "/tweets"
    end
  end
end