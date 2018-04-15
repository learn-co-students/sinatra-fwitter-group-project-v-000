class TweetsController < ApplicationController

  get '/tweets' do
    #shows all tweets
    if logged_in?
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    #CREATE: creates new tweets
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    #CREATE: creates new instance of tweets (creates a new tweet)
    if !params[:content].empty?
      @tweet = Tweet.create(:content => params[:content], :user_id => session[:user_id])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    #READ: shows specific tweet
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    #UPDATE: edit tweets contents
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] && @tweet.user_id == session[:user_id]
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    #UPDATE: update tweet instance
    if !params[:content].empty?
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = (params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    #DELETE: delete and insatnce of tweet
    #Chekcs that the creator of the tweet is deleting it
    @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id] && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    elsif !logged_in?
      redirect '/login'
    else
      redirect '/tweets'
    end
  end

end
