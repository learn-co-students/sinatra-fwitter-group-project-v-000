require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "victorias"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
    if user.save && user.username != "" && user.email != ""
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
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :"users/show"
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      @tweet = Tweet.create(params)
      @tweet.user_id = session[:user_id]
      @tweet.save
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:content] != ""
      tweet.content = params[:content]
      tweet.save
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
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
