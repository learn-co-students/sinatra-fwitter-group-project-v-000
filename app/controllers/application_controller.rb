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

  get '/signup' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if is_logged_in?
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

  get '/logout' do
    if is_logged_in?
      session.clear
    end
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'tweets/tweets'
  end

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])

    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
    end
    redirect '/tweets'
  end

  helpers do
   def is_logged_in?
     !!session[:user_id]
   end

   def current_user
     User.find(session[:user_id])
   end
  end

end
