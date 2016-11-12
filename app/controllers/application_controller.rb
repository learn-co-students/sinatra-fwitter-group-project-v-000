require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    unless session[:id]
      erb :signup
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    unless session[:id]
      erb :login
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if session[:id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/tweets' do
    if session[:id]
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if session[:id]
      erb :'/tweets/create'
    else
      redirect '/login'
    end
  end

  get '/tweets/:tweet_id' do
    if session[:id]
      @tweet = Tweet.find(params[:tweet_id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:tweet_id/edit' do
    if session[:id]
      @tweet = Tweet.find(params[:tweet_id])
      if @tweet.user_id == session[:id]
        erb :'/tweets/edit'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/signup' do
    if !params.detect{|k,v| v.empty?}
      user = User.create(params)
      session[:id] = user.id
      flash[:welcome] = "Welcome, #{user.username}!"
      redirect '/tweets'
    else
      if params[:username].empty?
        flash[:signup_error_1] = "Please enter User Name"
      end
      if params[:email].empty?
        flash[:signup_error_2] = "Please enter Email"
      end
      if params[:password].empty?
        flash[:signup_error_3] = "Please enter Password"
      end
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if !user
      flash[:login_error] = "Wrong username"
      redirect '/login'
    else
      if !user.authenticate(params[:password])
        flash[:login_error] = "Wrong password"
        redirect '/login'
      else
        session[:id] = user.id
        flash[:welcome] = "Welcome, #{user.username}!"
        redirect '/tweets'
      end
    end
  end

  post '/tweets/new' do
    unless params[:content].empty?
      tweet = Tweet.create(content: params[:content], user_id: session[:id])
      redirect "/tweets/#{tweet.id}"
    else
      flash[:tweet_error] = "Can't tweet blank!"
      redirect '/tweets/new'
    end
  end

  patch '/tweets/:tweet_id/edit' do
    unless params[:content].empty?
      tweet = Tweet.find(params[:tweet_id])
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      flash[:tweet_error] = "Can't tweet blank!"
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:tweet_id/delete' do
    if session[:id]
      tweet = Tweet.find(params[:tweet_id])
      if tweet.user_id == session[:id]
        tweet.delete
        redirect "/tweets"
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
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
