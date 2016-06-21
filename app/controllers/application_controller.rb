require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
      erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @all_tweets = Tweet.all
      erb :'/tweets/show'
    end
  end

  get '/login' do
    if !logged_in?
      erb :login
    else
      @user = current_user
      redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !logged_in? && @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      @user = current_user
      redirect '/tweets'
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

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show'
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      erb :'/tweets/new'
    end
  end

  post '/tweets/new' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
    @user = current_user
    @new_tweet = Tweet.create(content: params["content"], user_id: @user.id)
    redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
      if logged_in? && @user.id = @tweet.user_id
        erb :'/tweets/single'
      else
        redirect '/login'
      end
  end

  post '/tweets/:id' do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
      if @user.id == @tweet.user_id && @user != nil
       @tweet.delete
       redirect '/tweets'
      else
       redirect '/login'
      end 
  end

  get '/tweets/:id/edit' do
    @user = current_user
    @tweet = Tweet.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    else
    erb :'/tweets/edit'
    end
  end

  post '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    end
  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end



end