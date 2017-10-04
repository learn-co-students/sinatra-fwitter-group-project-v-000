class TweetsController < ApplicationController

  get '/tweets' do
    redirect to('/login') unless is_logged_in?
    @user = current_user
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    redirect to('/login') unless is_logged_in?
    erb :'tweets/new'
  end

  post '/tweets' do
    content = params[:content]
    unless content.empty?
      @tweet = Tweet.create(content: params[:content], user: current_user)
      redirect to("/tweets/#{@tweet.id}")
    else
      redirect to('/tweets/new')
    end
  end

  get '/tweets/:tweet_id' do
    redirect to('/login') unless is_logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    erb :'tweets/show'
  end

  delete '/tweets/:tweet_id' do
    @tweet = Tweet.find(params[:tweet_id])
    redirect to('/login') unless is_logged_in?
    redirect to '/tweets' unless @tweet.user_id == current_user.id
    @tweet.delete
    redirect to('/tweets')
  end

  get '/tweets/:tweet_id/edit' do
    redirect to('/login') unless is_logged_in?
    @tweet = Tweet.find(params[:tweet_id])
    erb :'tweets/edit'
  end

  patch '/tweets/:tweet_id' do
    redirect to("/tweets/#{params[:tweet_id]}/edit") if params[:content].empty?
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to("/tweets/#{@tweet.id}")
  end

end
