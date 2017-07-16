class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @tweet = current_user.tweets.create(content: params[:content])
    if @tweet.save
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    redirect '/login' unless logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id/edit' do
    redirect '/login' unless logged_in?
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user_id == current_user.id
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if @tweet && @tweet.user_id == current_user.id
      @tweet.content = params[:content] unless params[:content].empty?
      @tweet.save
      erb :'/tweets/show_tweet'
    else
      redirect '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = current_user.tweets.find_by_id(params[:id])
    if @tweet && @tweet.user_id == current_user.id
      @tweet.delete
      erb :'/tweets/tweets'
    else
      redirect '/tweets'
    end
  end

end
