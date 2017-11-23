class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    @users = User.all
    if !is_logged_in?
      redirect to "/login"
    else
      erb :'/tweets/tweets'
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
      @tweet.user = User.find(session[:id])
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  ######## SHOW TWEET #########
  get '/tweets/:id' do
    @tweet = Tweet.find(params["id"])
    if !is_logged_in?
      redirect '/login'
    else
      erb :'/tweets/show_tweet'
    end
  end

  ######## EDIT TWEET #########
  get '/tweets/:id/edit' do
    if !is_logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find(params["id"])
    if @tweet.user.id == current_user.id
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params["id"])
    if !(params["content"] == "")
      @tweet.update(content: params["content"])
      erb :'/tweets/show_tweet'
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  ######## DELETE TWEET #########

  post '/tweets/:id/delete' do
    @tweet = Tweet.find(params["id"])
    if !is_logged_in?
      redirect '/login'
    elsif @tweet.user_id == current_user.id
      @tweet.destroy
      redirect '/tweets'
    else
      redirect '/tweets'
    end
  end

end
