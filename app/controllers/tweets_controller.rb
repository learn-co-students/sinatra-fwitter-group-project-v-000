require './config/environment'
class TweetsController < ApplicationController
  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      current_user.tweets.create(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end
end
