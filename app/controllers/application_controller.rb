require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret_fwitter"
  end

  get '/' do

    if logged_in?
      @user = current_user
      redirect '/tweets'
    else
      erb :index
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
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
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
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find(session[:user_id])
    erb :'users/show'
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
      @tweets = Tweet.all
      @user = current_user
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

  post '/tweets/new' do
    @user = User.find(session[:user_id])

    if params[:content] == ''
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      erb :'tweets/show_tweet'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.user_id = session[:user_id]
      @user = User.find(@tweet.user_id)
      erb :'tweets/show_tweet'
    else
      redirect 'login'
    end
  end

  get '/tweets/:id/edit' do

    if logged_in? && current_user
      @tweet = Tweet.find(params[:id])
      @user = User.find(@tweet.user_id)
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @user = User.find_by(session[:user_id])

    if params[:content] == '' || @user.id != session[:user_id]
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
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
