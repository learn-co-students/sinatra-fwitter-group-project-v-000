class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params["content"].empty?
      @tweet = Tweet.create(content: params["content"], user_id: current_user.id)
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
    end
    redirect to "/tweets"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params["content"].empty?
      @tweet.update(content: params["content"])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to '/login'
    end
  end
end
