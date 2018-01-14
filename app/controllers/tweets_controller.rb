class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @tweets=Tweet.all
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      @tweet = current_user.tweets.create(content: params[:content])
    end
  end
end
