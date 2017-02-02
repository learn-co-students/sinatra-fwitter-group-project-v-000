require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    erb :"tweets/create_tweet"
  end

  post '/tweets/new' do
    @tweet = Tweet.create(params)
    redirect to '/tweets'
  end

  get '/users/:username_slug' do
    @user = User.find_by_slug(params[:username_slug])
    @tweets = @user.tweets.all
    erb :'/tweets/show_tweets'
  end

  get '/tweet/:id/edit' do

  end

  patch '/tweet/:id' do

  end

  post '/tweet/:id/delete' do

  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(params)
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to '/signup'
    else
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  post '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
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
