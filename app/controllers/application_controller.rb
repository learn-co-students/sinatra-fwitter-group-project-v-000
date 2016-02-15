require 'pry'
require './config/environment'

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
      @tweets = Tweet.all
      @user = current_user
      erb :'tweets/index'
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

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id].to_i)
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if @tweet.save
      redirect '/tweets'
    else
      redirect 'tweets/new'
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id].to_i)
    redirect '/tweets' if tweet.user_id != current_user.id
    tweet.delete
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id].to_i)
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id].to_i)
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.update(content: params[:content])
    redirect "tweets/#{@tweet.id}"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      log_in_user
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all{|tweet| tweet.user_id == @user.id}
    erb :'users/show'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      log_in_user
      redirect '/tweets'
    else
      redirect '/users/failure'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    end
    redirect '/'
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def log_in_user
      session[:id] = @user.id
    end
  end
  

end
