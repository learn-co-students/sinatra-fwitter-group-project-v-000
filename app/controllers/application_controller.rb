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
      redirect "/#{user.slug}/tweets"
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

  get '/tweets/:id/edit' do
    redirect '/failure' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/failure' if @tweet.user_id != session[:user_id]
    erb :"/tweets/edit_tweet"
  end

  get '/tweets/new' do
    redirect "/" if !logged_in?
    erb :"/tweets/create_tweet"
  end
  post '/tweets' do
    redirect "/failure" if !logged_in?
    user = User.find(session[:user_id])
    tweet = Tweet.create(:content => params[:content])
    user.tweets << tweet
    user.save
    redirect "/#{user.slug}/tweets"
  end

  get '/tweets/:id' do
    redirect "/failure" if !logged_in?
    @tweet = Tweet.find(params[:id])
    @user = User.find(@tweet.user_id)
    erb :"/tweets/show_tweet"
  end

  get '/:slug/tweets' do
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
