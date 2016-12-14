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
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      redirect "/tweets"
    else
      redirect "/signup_failure"
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
  user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login_failure"
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweeet'
  end

  post '/tweets' do
    @tweet = Tweet.create(params["tweet"])
    @tweet.save
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.save
    redirect to "tweets/#{@tweet.id}"
  end

end
