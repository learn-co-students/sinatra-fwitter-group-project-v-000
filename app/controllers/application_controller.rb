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

  get '/signup' do

    if logged_in?
      redirect to "/tweets"
    else
      erb :'users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/tweets' do

    if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do

    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params['id'])
    erb :"tweet/edit_tweet"
  end

  post '/signup' do

    @user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    @user.save

    if @user.save

      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end

  end

  post '/login' do

    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if params[:content] != ""
      tweet = Tweet.create(content: params[:content])
      tweet.user_id = session[:user_id]
      tweet.save
      redirect to "tweets/show"
    else
      redirect to 'tweets/new'
    end
  end

  post '/tweets/:id'do
    @tweet = Tweet.find_by(id: params['id'])
    redirect to "tweets/show"
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
