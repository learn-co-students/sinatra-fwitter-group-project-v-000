require './config/environment'

class TweetsController < ApplicationController

#All Tweets
  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

#New Tweet
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

#New Tweet- Form Submit
  post '/tweets' do
    if params[:content] == ""
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(:content => params["content"])
      @tweet.user_id = current_user.id
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

#Show Tweet
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

#Edit Tweet
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

#Edit Tweet- Form Submit
  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params["content"]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    end
  end

#Delete Tweet Action
  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.delete
    end
      redirect to "/tweets"
  end


end
