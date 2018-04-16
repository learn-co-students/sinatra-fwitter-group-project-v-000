class TweetController < ApplicationController

  get '/tweets' do

    @user = User.find_by(id: session["user_id"])
    @all_tweets = Tweet.all

    if logged_in
      erb :'tweets/tweets'
    else
      redirect to "/login"
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

  get '/tweets/new' do
    @user = User.find_by(session["user_id"])

    if @user
      erb :'tweets/create_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params["id"])
    @user = User.find_by(session["user_id"])

    if logged_in
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/delete' do
  end

  get '/tweets/:id/edit' do
    @user = User.find_by(session["user_id"])
    @tweet = Tweet.find_by(id: params["id"])

    if logged_in && @tweet.user_id == @user.id
      erb :'tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  post '/tweets/:id/edit' do
    binding.pry
    redirect to "/tweets/:id/edit"
  end


end
