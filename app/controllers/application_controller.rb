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
    if Helpers.is_logged_in?(session) == true
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
      Helpers.is_logged_in?(session) == true
      session[:user_id] = @user.id
      redirect('/tweets')
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session) == true
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
    if Helpers.is_logged_in?(session) == true
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/show_tweets'
    else
      redirect('/login')
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session) == true
      session.clear
      redirect('/login')
    else
      redirect('/')
    end
  end

  get '/users/:slug' do
    if Helpers.is_logged_in?(session) == true
      @user = User.find_by_slug(params[:slug])

     erb :'/users/show'
   else
     redirect('/login')
   end
  end
end
