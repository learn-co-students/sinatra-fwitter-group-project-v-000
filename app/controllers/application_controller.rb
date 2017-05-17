require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "wut"
  end

  get '/' do
    @users = User.all
    @tweets = Tweet.all
    erb :index
  end

  get '/tweets' do
    @users = User.all
    @tweets = Tweet.all
    erb :index
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :new
    else
      "not logged in #{session}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :show
    else
      redirect 'failure'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user == current_user
      erb :edit
    else
      redirect 'failure'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    else
      redirect '/tweets'
    end
  end

  get '/failure' do
    "You do not have proper access."
  end

  get '/login' do
    erb :login
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/failure'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username],:email => params[:email],
     :password => params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/failure'
    end
  end

  post '/tweets' do
    params[:tweet][:user] = current_user
    tweet = Tweet.new(params[:tweet])
    tweet.save

    redirect "/tweets/#{tweet.id}"
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(params[:tweet])

    redirect "/tweets/#{tweet.id}"
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if tweet.user == current_user
      tweet.delete
      redirect '/'
    else
      redirect '/failure'
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
