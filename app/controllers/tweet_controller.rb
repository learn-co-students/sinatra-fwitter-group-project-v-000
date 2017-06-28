class TweetController < ApplicationController
  require './config/environment'

  get '/tweets' do
    if logged_in?
      @users = User.all
      @tweets = Tweet.all
      @user = current_user
      erb :"/tweets/index"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?  #had to add this in to get test to pass
      redirect '/login' # not sure why lines 42-43 did not cover it
    end
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user == current_user
      erb :"/tweets/edit"
    elsif logged_in?
      redirect "/tweets/#{params[:id]}"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    params[:tweet][:user] = current_user
    tweet = Tweet.new(params[:tweet])
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  post '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params[:tweet][:content] != ""
      tweet.update(params[:tweet])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  post '/tweets/:id/delete' do
    tweet = Tweet.find(params[:id])

    if tweet.user == current_user
      tweet.delete
      redirect '/'
    else
      redirect '/tweets'
    end
  end

end
