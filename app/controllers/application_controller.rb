require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, 'secret'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect to '/tweets' if logged_in?
    erb :'users/create_user'
  end

  get '/login' do
    redirect to '/tweets' if logged_in?
    erb :'/users/login'
  end

  get '/tweets' do
    redirect to '/login' unless logged_in?
    @user = current_user
    erb :'/tweets/tweets'
  end

  get '/tweets/new' do
    redirect to '/login' unless logged_in?
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      if @tweet.user == current_user
        erb :'/tweets/edit_tweet'
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete if logged_in? && (@tweet.user == current_user)
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear if logged_in?
    redirect to '/login'
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && (@tweet.user == current_user)
      @tweet.update(content: params['content'])
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    if logged_in? && params['content'] != ''
      @user = current_user
      @tweet = Tweet.create(params)
      @tweet.user = @user
      @tweet.save
      redirect to '/tweets'
    elsif !logged_in
      redirect to '/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params['username'])
    if @user && @user.authenticate(params['password'])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect to 'login'
    end
  end

  post '/signup' do
    if params[:username] != '' && params[:email] != '' && params[:password] != ''
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    if current_user
      true
    else
      false
    end
  end
end
