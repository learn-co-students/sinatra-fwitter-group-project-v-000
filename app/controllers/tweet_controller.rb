require './config/environment'

class TweetController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content])
      current_user.tweets << @tweet
      erb :'tweets/show_tweet'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(:id => params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(:id => params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      @tweet.destroy
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(:id => params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(:id => params[:id])
    if !params[:content].empty?
      @tweet.content = params[:content]
      @tweet.save
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

end
