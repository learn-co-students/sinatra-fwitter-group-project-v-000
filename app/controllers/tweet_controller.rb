class TweetController < ApplicationController

  #Havent checked the order of the routes yet

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