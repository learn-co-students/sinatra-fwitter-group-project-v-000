class TweetsController < ApplicationController
  
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweet = Tweet.all 
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end
  
  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end
  
  post '/tweets' do
    if logged_in?
      if params[:content].empty?
        redirect to '/tweets/create_tweet'
      else
        @tweet = current_user.tweets.create(content: params[:content]) 
        redirect to '/tweets/#{@tweet.id}'
      end
    else
      redirect to '/login'
    end
  end
  
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end
  
  get '/tweets/:id/edit' do
     if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end
  
  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if params[:content].empty?
      @tweet.update(:content => params[:content])
      redirect to '/tweets/#{@tweet.id}'
    else
      redirect '/tweets'
    end
  end
  
  delete '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user.id = @tweet.user.id
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
  
end
