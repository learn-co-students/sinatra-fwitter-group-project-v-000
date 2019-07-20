class TweetsController < ApplicationController

  get '/tweets' do
    @user = User.find_by(params)
    if logged_in?
     erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    erb :"/tweets/new"
  end

  post '/tweets' do
    @tweet = Tweet.create(params)
    @tweet.user_id = current_user.id
    @tweet.save

    redirect "/tweets"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params)
    @user = User.find_by_id(@tweet.user_id)
    erb :"/tweets/show_tweet"
  end


end
