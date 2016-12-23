class TweetsController < ApplicationController

  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all 
      erb :'/tweets/tweets'
    else 
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet' 
     else 
      redirect to '/login'
    end 
  end
  
  post '/tweets' do
    tweet = Tweet.new(content: params[:content])
    tweet.user = current_user
    if tweet.save 
      redirect "/tweets/#{tweet.id}"
    else 
      redirect to '/tweets/new'
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
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.content = params[:content]
      @tweet.save 
      redirect to "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do 
    if logged_in?
      tweet = Tweet.find(params[:id])
      if tweet.user == current_user
        tweet.delete
        redirect to "/tweets"
      end
    end

  end

 end