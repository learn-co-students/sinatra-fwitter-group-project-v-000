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

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
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
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      user = User.create(params)
      session[:id] = user.id
      redirect '/tweets'
    end
  end

  post '/login' do
    if params[:username] == "" || params[:password] == ""
      erb :'users/login', locals: {message: "Please enter your username and password."}
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:id] = user.id 
        redirect '/tweets'
      else
        erb :'users/login', locals: {message: "Incorrect username or password."}
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'users/show_user'
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = current_user
    if !params[:content].empty?
      @tweet = Tweet.create(content: params[:content])
      @tweet.user = @user 
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user == @tweet.user
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && current_user == @tweet.user
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end