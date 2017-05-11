require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
       redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? &&!params[:password].empty?
      @user = User.create(params)
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:id])
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    end

    redirect '/login'
  end

  get '/tweets/new' do
    if logged_in?
      @user = User.find(session[:id])
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/users/:user_id' do
    if logged_in?
      @user = User.find(params[:user_id])
      if !params[:content].empty?
        @user.tweets << Tweet.create(content: params[:content])
        erb :"/tweets/tweets"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/users/:user_id' do
      @user = User.find(params[:user_id])
      erb :"/tweets/show_tweet"
  end

  get '/tweets/:tweet_id' do
    if logged_in?
      @tweet = Tweet.find(params[:tweet_id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:tweet_id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:tweet_id])
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  delete '/tweets/:tweet_id/delete' do
    if logged_in?
      tweet = Tweet.find(params[:tweet_id])
      if session[:id] == tweet.user_id
        tweet.delete
        redirect '/tweets'
      end
    end
      redirect '/login'
  end

  patch '/tweets/:tweet_id' do
    if logged_in?
      @tweet = Tweet.find(params[:tweet_id])

      if !params[:content].empty?
        @tweet.content = params[:content]
        @tweet.save
        erb :"/tweets/show_tweet"
      else
        redirect "/tweets/#{@tweet.id}/edit"
      end
    else
      redirect '/login'
    end
  end
end

def logged_in?
  if session[:id]
    true
  else
    false
  end
end
