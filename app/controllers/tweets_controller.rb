class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets/new' do
    content = params[:content]
    if logged_in?
      if content != ""
        tweet = Tweet.new(user_id:session[:user_id], content:params[:content])
        current_user.tweets << tweet
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end
  
  patch '/tweets/:id/edit' do
    if logged_in?
      if params[:content] != ""
        @tweet = Tweet.find_by(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user.id == @tweet.user_id
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end
