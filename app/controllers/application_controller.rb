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

  ### CREATE USER ###
  get '/users/new' do
    erb :'users/create_user'
  end

  post '/users/new' do
    if !params[username].empty? && !params[password].empty? && !params[email].empty?
      user = User.create(username: params[username], email: params[email], password_digest: params[password])
      redirect "/tweets/#{user.username}"
    else
      session[:failure] = "There was an error creating your account. Please try again."
      redirect "/users/new"
    end
  end

  ### LOGIN USER ###
  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do 
    #veryify the username and password are entered and authenticated.
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets/#{user.username}"
    else
      session[:failure] = "There was an error logging in. Please try again."
      redirect
    end
    #if neither then redirect back to login with flash message?
    erb :login
  end






  #### TWEETS #####



  ### NEW TWEET ###
  get '/tweets/:username/new' do
    # verify user is logged in first or else take them back to log in page.
    erb :create_tweet
  end

  post '/tweets/:username/new' do
    user = User.find_by(username: params[:username])
    #create tweet
    redirect "/tweets/#{user.username}"
  end

  ### EDIT TWEET ###
  get '/tweets/:username/:tweet_id/edit' do
    # verify user is logged in first or else take them back to log in page.
    @tweet = User.find_by(username: params[:username]).tweets.find(params[:tweet_id])
    erb :edit_tweet
  end

  post '/tweets/:username/:tweet_id' do
    user = User.find_by(username: params[:username])
    tweet = user.tweets.find(params[:tweet_id])
    #update the tweet content and save!
    redirect "/tweets/#{user.username}" #or go to show_tweet?
  end

  ### SHOW ALL TWEETS ###
  get '/tweets/:username' do
    # verify user is logged in first or else take them back to log in page.
    @tweets = User.find_by(username: params[:username]).tweets
    erb :tweets
  end

  ### SHOW A SINGLE TWEET ###
  get '/tweets/:username/:tweet_id' do
    # verify user is logged in first or else take them back to log in page.
    @tweet = User.find_by(username: params[:username]).tweets.find(params[:tweet_id])
    erb :show_tweet
  end

  ### DELETE A TWEET ###
  delete "/tweets/:username/:tweet_id" do 
    # verify user is logged in first or else take them back to log in page.
    User.find_by(username: params[:username]).tweets.find(params[:tweet_id]).delete
    erb :tweets
  end

end