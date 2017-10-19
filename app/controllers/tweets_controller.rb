require 'pry'

class TweetsController < ApplicationController

#Tweet Index

  get "/tweets" do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

#Create Tweet

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = Tweet.create(:content => params[:content])
      current_user.tweets << @tweet

      redirect to "/tweets/#{@tweet.id}"
    end
  end

#Delete Tweet

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end
