require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "garland"
  end

  get '/' do 
    erb :index
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all.find { |tweet| tweet.user_id == @user.id }
    erb :'tweets/tweets'
  end

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to('/login')
    end
  end

  get '/tweets/new' do 
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to('/login')
    end
  end

  get '/login' do
    if is_logged_in?
      redirect to('/tweets')
    else
      erb :'users/login'
    end
  end

  get '/signup' do 
    if is_logged_in?
      redirect to('/tweets')
    else
      erb :'users/create_user'
    end
  end

  get '/logout' do 
    if is_logged_in?
      session.clear
      redirect to('/login')
    else
      redirect to('/')
    end
  end

  get '/tweets/:id/edit' do 
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in? && @tweet.user_id == session[:id]
      erb :'tweets/edit_tweet'
    else
      redirect to('/login')
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to('/login')
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content], user_id: session[:id])
    if @tweet.save
      redirect to("/tweets/#{@tweet.id}")
    else
      redirect to('/tweets/new')
    end
  end

  post '/signup' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:id] = @user.id
      redirect to('/tweets')
    else
      redirect to('/signup')
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:id] = @user.id 
      redirect to('/tweets')
    else
      redirect to('/login')
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if is_logged_in? && @tweet.user_id == session[:id]
      @tweet.destroy
      redirect to('/tweets')
    else
      redirect to("/tweets/#{params[:id]}")
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.update(content: params[:content])
      redirect to("/tweets/#{params[:id]}")
    else
      redirect to("/tweets/#{params[:id]}/edit")
    end
  end

  helpers do
    def is_logged_in?
      !!session[:id]
    end

    def current_user
      User.find_by(id: session[:id])
    end

  end

end