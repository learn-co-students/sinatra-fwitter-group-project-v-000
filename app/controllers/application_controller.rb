require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fwitter secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'index'
  end

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params.value?("")
      @user = User.create(params)
      if @user
        session[:user_id] = @user.id
        redirect '/tweets'
      end
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
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
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
    if !params.value?("")
      @tweet = Tweet.new(params)
      current_user.tweets << @tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user == current_user
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user == current_user
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
 
  post '/tweets/:id' do
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.update(content: params[:content])
      redirect '/tweets'
    else
      redirect "/tweets/#{params[:id]}/edit"
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
