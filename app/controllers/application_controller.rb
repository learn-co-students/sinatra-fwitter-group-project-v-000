require './config/environment'
require "./app/models/user"

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
  
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])

    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end
  
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/logout' do
    session[:user_id] = nil
    redirect '/login'
  end  
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    if @user
      erb :"users/show"
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    user = current_user
    tweet = Tweet.new(:content => params[:content], :user_id => user.id)
    
    if tweet.content != ""
      tweet.save
      redirect "/users/#{user.slug}"
    else 
      redirect '/tweets/new'
    end
  end
  
  get '/tweets/:id' do
    @tweet = Tweet.find_by(:id => params[:id])
    
    if logged_in?
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(:id => params[:id])
    if logged_in? && @tweet.user == current_user
      erb :'tweets/edit'
    else 
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    tweet = Tweet.find_by(:id => params[:id])
    
    if params[:content] == ""
      redirect "tweets/#{tweet.id}/edit"
    else
      tweet.update(:content => params[:content])
      redirect "tweets/#{tweet.id}"
    end
  end
  
  patch '/tweets/:id/delete' do
    tweet = Tweet.find_by(:id => params[:id])
    
    if logged_in? && tweet.user == current_user
      tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
    
  end
    
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(:id => session[:user_id])
    end
  end
  
end