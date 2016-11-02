require 'pry'
class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in
      if params[:content].length <= 140
        @tweet = current_user.tweets.build(params)
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      else
        redirect to "/tweets/new"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in
      @tweet = Tweet.find_by_id(params[:id])
      if current_user.tweets.include?(@tweet)
        erb :'/tweets/edit'
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    if logged_in
      @tweet = Tweet.find_by_id(params[:id])
      if current_user.tweets.include?(@tweet)
        @tweet.content = params[:content]
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/delete' do
    if logged_in
      @tweet = Tweet.find_by_id(params[:id])
      if current_user.tweets.include?(@tweet)
        @tweet.destroy
        redirect to "/tweets"
      else
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect '/login'
    end
  end

end
