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

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/signup"
    end
  end

  post "/signup" do
    user = User.new(params)

    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do 
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params["id"])
    if logged_in?
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do 
    @tweet = Tweet.create(params)
    @tweet.user_id = current_user.id
    
    if @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id/edit' do 
    @tweet = Tweet.find_by_id(params["id"])
    if logged_in? && @tweet
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params["id"])
    @tweet.content = params["content"]
    if @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do 
    @tweet = Tweet.find_by_id(params["id"])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do 
    @user = User.find_by_slug(params["slug"])
    @tweets = @user.tweets

    erb :"/users/show_user_tweets"
  end

  get "/logout" do
    session.clear
    redirect "/login"
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