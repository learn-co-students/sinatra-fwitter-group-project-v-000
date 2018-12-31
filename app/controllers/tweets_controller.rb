class TweetsController < ApplicationController
  
  get '/tweets' do
    #binding.pry
    if logged_in?
      @tweets = Tweet.all
      @user = current_user 
      erb :"/tweets/tweets"
    else 
      redirect "/login"
    end 
  end 
  
  get '/tweets/new' do
    #binding.pry 
    if logged_in? 
      erb :"/tweets/new"
    else 
      redirect "/login"
    end 
  end 
  
  post '/tweets' do
    #binding.pry 
    tweet = Tweet.new(params)
    tweet.user = current_user 
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else 
      redirect "/tweets/new"
    end 
  end 
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else 
      redirect :"/login"
    end 
  end 
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else 
      redirect "/login"
    end 
  end 
  
  patch '/tweets/:id' do
    #binding.pry 
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == tweet.user_id && !params[:content].empty?
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    elsif logged_in? && current_user.id == tweet.user_id && params[:content].empty?
      redirect "/tweets/#{tweet.id}/edit"
    elsif logged_in? && current_user.id != tweet.user_id && params[:content]
      redirect "/tweets"
    else 
      redirect "/login"
    end 
  end 
  
  delete '/tweets/:id/delete' do 
    tweet = Tweet.find(params[:id])
    if logged_in? && current_user.id == tweet.user_id 
      tweet.destroy 
      redirect "/tweets"
    elsif logged_in?
      redirect "/tweets"
    else 
      redirect "/login"
    end 
  end 

end
