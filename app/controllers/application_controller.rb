require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ftweet"
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :"users/login"
  end
  post '/login' do
    user = User.find_by(:user_name => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/#{user.id}/tweets"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  get '/signup' do
    erb :"users/create_user"
  end
  post '/signup' do
    user = User.new(:user_name => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end

  get '/tweets/new' do
    redirect "/" if !logged_in?
    erb :"/tweets/create_tweet"
  end
  post '/tweets' do
    redirect "/failure" if !logged_in?
    binding.pry
    @user = User.find(session[:id])
    @tweet = Tweet.new(params[:content])
  end

  get '/:id/tweets' do
    redirect "/failure" if !logged_in?
    @user = current_user()
    redirect "/failure" if !@user
    erb :"/tweets/tweets"
  end

  get '/failure' do
    erb :failure
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
