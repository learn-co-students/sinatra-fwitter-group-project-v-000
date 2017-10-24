require './config/environment'
require "./app/models/user"
require "./app/models/tweet"

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
    if is_logged_in?
      redirect('/tweets')
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

    if @user.username == ""
      redirect('/signup')
    elsif @user.email == ""
      redirect('/signup')
    elsif @user.save == false
      redirect('/signup')
    else
      @user.save
      is_logged_in? == true
      session[:user_id] = @user.id
      redirect('/tweets')
    end
  end

  get '/login' do
    if is_logged_in?
      redirect('/tweets')
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect('/tweets')
    end
  end

  get '/tweets' do
    if is_logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      #binding.pry
      erb :'/tweets/show_tweets'
    else
      redirect('/login')
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect('/login')
    else
      redirect('/')
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])

     erb :'/users/show'
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect('/login')
    end
  end

  get '/tweets/:id' do
    erb :'/tweets/single_tweet'
  end

  post '/tweets' do
    @tweet = Tweet.create(:content => params[:content])
    @tweet.save
    current_user.tweets << @tweet
    
    redirect('/tweets/:id')
  end


  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end
  end
end
