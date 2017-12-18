class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end
  
  post '/tweets' do
    if logged_in?
      @user = current_user
      tweet = Tweet.new(:content => params[:content])
      if tweet.content.empty?
        redirect '/tweets/new'
      else
        tweet.save
        @user.tweets << tweet
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :"/tweets/create_tweet"
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id' do 
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && !@tweet.nil?
      erb :"/tweets/show_tweet"
    elsif logged_in? && @tweet.nil?
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in? && current_user.tweets.ids.include?(params[:id].to_i)
      @tweet = Tweet.find_by_id(params[:id])
      erb :"/tweets/edit_tweet"
    elsif logged_in? && !current_user.tweets.ids.include?(params[:id].to_i)
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.content = params[:content]
    if @tweet.content.empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end
  
  delete '/tweets/:id' do
    if logged_in? && current_user.tweets.ids.include?(params[:id].to_i)
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.destroy
      redirect '/tweets'
    elsif logged_in? && !current_user.tweets.ids.include?(params[:id].to_i)
      redirect '/tweets'
    else
      redirect '/login'
    end
  end
end