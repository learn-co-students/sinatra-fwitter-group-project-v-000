require 'pry'
class TweetController < ApplicationController

#EDIT WITH SESSIONS AND USERS

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else redirect '/login'
    end
  end

  get '/tweets/new' do
     if logged_in?
      @user = User.find(session[:user_id])
      erb :'tweets/create_tweet'
    else redirect '/index'
    end
  end

  post '/tweets' do

    @tweet = Tweet.create(content:params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'tweets/edit_tweet'
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content:params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  patch '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @tweet.delete
    redirect '/tweets'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end
end
