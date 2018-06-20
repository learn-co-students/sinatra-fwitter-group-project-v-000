require './config/environment'

class TweetsController < ApplicationController

#All Tweets
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

#New Tweet
  get '/tweets/new' do
  #  @tweet =
    erb :'/tweets/create_tweet'
  end

#New Tweet- Form Submit
  post '/tweets' do
    @tweet = Tweet.create(:content => params["content"])
      #how do I incorporate the user_id for each new tweet?
      #should be able to pull from the current_user I think?
    @tweet.save
    redirect to "tweet/#{@tweet.id}"
  end

#Show Tweet
  get '/tweet/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

#Edit Tweet
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit_tweet'
  end

#Edit Tweet- Form Submit
  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params["content"]
    @tweet.save
    redirect to "tweet/#{@tweet.id}"
  end

end
