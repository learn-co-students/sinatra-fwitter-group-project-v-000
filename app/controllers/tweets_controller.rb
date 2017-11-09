require 'sinatra/base'
require 'rack-flash'

class TweetsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      flash[:message] = "Please log in to write a tweet."
      redirect to '/login'
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.new(content: params[:content])
      @tweet.save
      @user = current_user
      @user.tweets << @tweet
      redirect to "/tweets/#{@tweet.id}"
    else
      flash[:message] = "Please write something to post!"
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in? #FlatIron Twitter is more exclusive than real Twitter
      @user = current_user
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && !params["content"].empty?
      @tweet.update(content: params[:content])
      @tweet.save
    else
      redirect to "/tweets/1/edit"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        redirect to "/tweets"
      end
    else
      redirect '/login'
    end
  end

end #class end
