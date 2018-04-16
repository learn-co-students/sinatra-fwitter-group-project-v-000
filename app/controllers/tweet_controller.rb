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
    content = params["content"]

    if content.chars.any? { |char| ('a'..'z').include? char.downcase}
      @tweet = Tweet.new
      @tweet.content = params["content"]
      @tweet.user_id = @user.id
      @tweet.save
      erb :'tweets/show_tweet'
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

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params["id"])
    @tweet.content = params["content"]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}/edit"
  end

  delete '/tweets/:id' do
    @user = User.find_by(session["user_id"])
    @tweet = Tweet.find_by(id: params["id"])
    if logged_in && @user.id == @tweet.user_id
      @tweet.delete
    end
  end


end
