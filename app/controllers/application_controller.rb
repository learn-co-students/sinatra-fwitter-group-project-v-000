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

  ## CREATE USER ###
  get '/signup' do
    if !!session[:id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      session[:id] = user.id
      redirect "/#{user.slug}/tweets"
    else
      redirect "/signup"
    end
  end

  ### LOGIN USER ###
  get '/login' do
    if !!session[:id]
      user = User.find(session[:id])
      redirect "/#{user.slug}/tweets"
    else
      erb :'users/login'
    end
  end

  post '/login' do 
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/#{user.slug}/tweets"
    else
      redirect "/login"
    end
  end

  ### LOGOUT USER ###
  get '/logout' do
    if !!session[:id]
      session.clear
      redirect "/login"
    else 
      redirect "/"
    end
  end





  #### TWEETS #####



  # ### NEW TWEET ###
  # get '/tweets/new' do
  #   if !!session[:id]
  #     user = User.find(session[:id])
  #     # verify user is logged in first or else take them back to log in page.
  #     erb :create_tweet
  #   else
  #     redirect "/login"
  #   end
  # end

  # post '/tweets/:username/new' do
  #   user = User.find_by(username: params[:username])
  #   #create tweet
  #   redirect "/tweets/#{user.username}"
  # end

  # ### EDIT TWEET ###
  # get '/tweets/:username/:tweet_id/edit' do
  #   if !!session[:id]
  #     @tweet = User.find_by(username: params[:username]).tweets.find(params[:tweet_id])
  #     erb :edit_tweet
  #   else
  #     redirect "/login"
  #   end
  # end

  # post '/tweets/:username/:tweet_id' do
  #   user = User.find_by(username: params[:username])
  #   tweet = user.tweets.find(params[:tweet_id])
  #   #update the tweet content and save!
  #   redirect "/tweets/#{user.username}" #or go to show_tweet?
  # end

  ### SHOW ALL TWEETS ###
  get '/:slug/tweets' do
    if !!session[:id]
      @user = User.find(session[:id])
      erb :'tweets/tweets'
    else 
      redirect "/login"
    end
  end

  # ### SHOW A SINGLE TWEET ###
  # get '/tweets/:username/:tweet_id' do
  #   if !!session[:id]
  #     @tweet = User.find_by(username: params[:username]).tweets.find(params[:tweet_id])
  #     erb :show_tweet
  #   else
  #     redirect "/login"
  #   end
  # end

  # ### DELETE A TWEET ###
  # delete "/tweets/:username/:tweet_id" do 
  #   if !!session[:id]
  #     User.find_by(username: params[:username]).tweets.find(params[:tweet_id]).delete
  #     erb :tweets
  #   else
  #     redirect "/login"
  #   end
  # end

end