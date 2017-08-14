require './config/environment'
require 'rack-flash'
class TweetController < ApplicationController
  use Rack::Flash

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if params[:content] == ""
      redirect to "/tweets/new"
    else
      @tweet = Tweet.new(params)
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect to "/tweets"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :"tweets/edit_tweet"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete'do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user.id
        @tweet.delete
        flash[:message] = "Successfully deleted tweet!"
        redirect to "/tweets"
      else
        redirect to "/tweets"
      end
    else
      redirect to "/login"
    end
  end
end
