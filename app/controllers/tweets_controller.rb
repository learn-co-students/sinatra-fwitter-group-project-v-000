class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && !params[:tweet_content].empty?
      tweet = Tweet.create(:content => params[:tweet_content], :user_id => current_user.id)
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    elsif logged_in? && !params[:tweet_content].empty?
      tweet = Tweet.find(params[:id])
      tweet.content = params[:tweet_content]
      tweet.save
      redirect "/tweets/#{params[:id]}"
    else
      redirect "/tweets/#{params[:id]}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == tweet.user_id
      tweet.delete
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect '/login'
    end
  end


end
