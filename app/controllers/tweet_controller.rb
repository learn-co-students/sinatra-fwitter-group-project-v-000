class TweetController < ApplicationController

  get '/tweets' do

    @user = User.find_by(id: session["user_id"])

    if logged_in
      erb :'tweets/tweets'
    else
      redirect to "users/login"
    end
  end

  get '/tweets/new' do
    @user = User.find_by(session["user_id"])

    if @user
      erb :'tweets/create_tweet'
    else
      redirect to "/"
    end
  end

  post '/tweets/new' do
    @user = User.find_by(session["user_id"])

    if params["content"] != ""
      @tweet = Tweet.new
      @tweet.content = params["content"]
      @tweet.user_id = @user.id
      @tweet.save
    else
      redirect to "tweets/new"
    end
  end


end
