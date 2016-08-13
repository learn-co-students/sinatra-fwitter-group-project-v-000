class TweetController < ApplicationController

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