class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    @users = User.all
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  ######## CREATE TWEET #########
  get '/tweets/new' do
    if !is_logged_in?
      redirect to '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    if !(params["content"] == "")
      @tweet = Tweet.create(content: params["content"])
      @tweet.user = User.find_by(username: session["username"])
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  ######## SHOW TWEET #########
  get '/tweets/:id' do
    @tweet = Tweet.find(params["id"])
    if session["username"] == nil
      redirect '/login'
    elsif @tweet.user.username == session["username"]
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets'
    end
  end

  ######## EDIT TWEET #########
  get '/tweets/:id/edit' do
    erb :'/tweets/edit_tweet'
  end

  post '/tweets/:id' do
    erb :'/tweets/show_tweet'
  end

  ######## DELETE TWEET #########

  post '/tweets/:id/delete' do
    erb :'/tweets/show_tweet'
  end

end
