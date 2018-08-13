class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = current_user.tweets
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in
      @current_user = current_user
      erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    @tweet = Tweet.new(content: params[:content])
    if @tweet.content != ""
      current_user.tweets << @tweet
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end 
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      erb :'/tweets/edit_tweet'
    else
      erb :'/users/error'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] != ""
      @tweet.content = params[:content]
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    else
      erb :'/users/error'
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] == @tweet.user_id
      @tweet.delete
      redirect "/show/#{current_user.id}"
    else
      erb :'/users/error'
    end
  end

end
