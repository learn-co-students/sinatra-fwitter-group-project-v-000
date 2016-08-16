require 'pry'

class TweetsController < ApplicationController
  get '/tweets' do
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @user = User.find(session[:user_id])
      @tweet = Tweet.create(content: params[:content])
      @user.tweets << @tweet
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if !!session[:user_id]
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        erb :"/tweets/show_tweet"
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !!session[:user_id]
      @user = User.find(session[:user_id])
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !params[:content].empty?
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  post "/tweets/:id/delete" do
    if !!session[:user_id]
      @tweet = Tweet.find(params[:id])
      if session[:user_id] == @tweet.user_id
        @tweet = Tweet.find(params[:id])
        @tweet.delete
        redirect "/tweets"
      else
        redirect "/tweets"
      end
    else
      redirect '/login'
    end
  end
end
