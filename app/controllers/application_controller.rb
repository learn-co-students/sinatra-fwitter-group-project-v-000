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
    if logged_in?
      redirect '/tweets'
    end
    erb :"users/login"
  end
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    end
    erb :"users/create_user"
  end
  post '/signup' do
    # fields required in erb but additional check for test (or if someone bypasses the form)
    if params[:username].length == 0 || params[:email].length == 0 || params[:password].length == 0
      redirect '/signup'
    end
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    redirect "/failure" if !user.save
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    redirect '/failure' if !logged_in?
    @tweet = Tweet.find(params[:id])
    redirect '/failure' if @tweet.user_id != session[:user_id]
    erb :"/tweets/edit_tweet"
  end

  get '/tweets/new' do
    redirect "/login" if !logged_in?
    erb :"/tweets/create_tweet"
  end
  post '/tweets' do
    redirect "/login" if !logged_in?
    # content required in form but just in case someone bypasses form
    redirect '/tweets/new' if params[:content].length == 0
    user = User.find(session[:user_id])
    tweet = Tweet.create(:content => params[:content])
    user.tweets << tweet
    user.save
    redirect "/tweets"
  end

  get '/tweets/:id' do
    redirect "/failure" if !logged_in?
    @tweet = Tweet.find(params[:id])
    @user = User.find(@tweet.user_id)
    redirect "/failure" if current_user.id != @tweet.user_id
    erb :"/tweets/show_tweet"
  end

  get '/tweets' do
    redirect "/login" if !logged_in?
    @user = current_user
    @tweets = Tweet.all
    erb :"/tweets/tweets"
  end
  get '/users/:slug' do
#    redirect "/login" if !logged_in?
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
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
