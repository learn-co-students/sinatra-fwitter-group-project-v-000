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

  get '/tweets' do
    if logged_in?
      @user = current_user
      @all_tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if @user = User.find_by_id(session[:user_id])
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if @user = User.find_by_id(session[:user_id])
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    if @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
    redirect '/'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all.find {|tweet| tweet.id == params[:id].to_i}
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @user.id == @tweet.user_id
        erb :'tweets/edit'
      end
    else
      redirect '/login'
    end
  end


  post '/tweets' do
    if logged_in?
      @user = current_user
      if !params[:content].empty?
        @user.tweets.create(params)
        redirect '/tweets'
      else
        redirect '/tweets/new'
      end
    else
      redirect '/'
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

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      if @user.id == @tweet.user_id
        @tweet.destroy
      end
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
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
