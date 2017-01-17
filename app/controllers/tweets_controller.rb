class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'/tweets/tweets'
    else redirect '/login'
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
    redirect '/tweets/new' if params[:content].empty?
    @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    @tweet.save
    erb :'/tweets/show_tweet'
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
    if @tweet
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content] unless params[:content].empty?
    @tweet.save
    erb :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete if @tweet.user_id == current_user.id
    erb :'/tweets/tweets'
  end

end
