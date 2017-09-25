require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # Set up sessions
    enable :sessions
    set :session_secret, "password_security"
  end

  # allow visit to homepage
  get '/' do
    erb :index
  end

  # allow visit to signup page unless logged in
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  # allow visit to tweets page if logged in
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  # signup form action to create new user
  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if !params[:email].empty? && !params[:username].empty? && !params[:password].empty? && @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      # if form isn't filled out correctly
      redirect '/signup'
    end
  end

  # allow visit to login page unless logged in
  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  # login form action
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      # start new session if user is authenticated
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      # if form isn't filled out correctly
      redirect '/login'
    end
  end

  # allow logout for logged in users
  get '/logout' do
    if logged_in?
      # end session & redirect logged out user to login
      session.clear
      redirect '/login'
    else
      # send logged out users to login
      redirect '/login'
    end
  end

  # allow visit to individual user's page
  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'users/show'
  end

  # allow logged in users to create new tweets
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create'
    else
      redirect '/login'
    end
  end

  # allow visit to individual tweet page if logged in
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  # tweet creation form action
  post '/tweets' do
    # only allow tweet to be created if tweet has content
    if !params[:content].empty?
      @user = User.find(session[:user_id])
      @user.tweets.build(content: params[:content])
      @user.save
      tweet = @user.tweets.last
      # send user to new tweet's page
      redirect "/tweets/#{tweet.id}"
    else
      # if tweet lacks content
      redirect '/tweets/new'
    end
  end

  # allow edit tweet if user is logged in and creator of tweet
  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if logged_in? && current_user.tweets.include?(@tweet)
        erb :'tweets/edit'
      else
        redirect '/tweets'
      end
    end
  end

  # edit form action
  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      # edit tweet unless tweet lacks content
      @tweet.update(content: params[:content])
      # send user to edited tweet's page
      redirect "/tweets/#{@tweet.id}"
    else
      # if tweet lacks content
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  # allow user to delete tweet
  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      # only delete if user is logged in and creator of tweet
      @tweet.delete
      redirect '/tweets'
    elsif logged_in?
      # send to /tweets page if logged in other user
      redirect '/tweets'
    else
      # send to login if not logged in
      redirect '/login'
    end
  end

  helpers do
    # get current user as object
    def current_user
      User.find(session[:user_id])
    end

    # determin if user is logged in
    def logged_in?
      # check if current session has a user_id
      !!session[:user_id]
    end
  end
end
